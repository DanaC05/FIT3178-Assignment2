//
//  CoreDataController.swift
//  Assigment 2
//
//  Created by Dana Casella on 28/4/21.
//

import UIKit
import CoreData

class CoreDataController: NSObject, DatabaseProtocol, NSFetchedResultsControllerDelegate {
    
    var listeners = MulticastDelegate<DatabaseListener>()
    var persistentContainer: NSPersistentContainer
    var childContext: NSManagedObjectContext
    let DEFAULT_MEAL_LIBRARY_NAME = "My Meals"
    var allLibraryMealsFetchedResultsController: NSFetchedResultsController<Meal>?
    var allMealIngredientsFetchedResultsController: NSFetchedResultsController<IngredientMeasurement>?
    var allIngredientsFetchedResultsController: NSFetchedResultsController<Ingredient>?
    
    override init() {
        childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        persistentContainer = NSPersistentContainer(name: "MealDataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data Stack with error: \(error)")
            }
        }
        super.init()
    }
    
    
    // save changes to main context (i.e will save changes to core data)
    func cleanUp() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                fatalError("Failed to save core data with error: \(error)")
            }
        }
    }
    
    // save changes to child context (will save changes to child context but not yet to core data)
    func tidyUp() {
        if childContext.hasChanges {
            do {
                try childContext.save()
            } catch {
                fatalError("Failed to save to parent with error: \(error)")
            }
        }
    }
    
    func addMeal(mealData: MealData) -> Meal? {
        // create meal object
        let meal = NSEntityDescription.insertNewObject(forEntityName: "Meal", into: persistentContainer.viewContext) as! Meal
        
        // set meal data
        meal.name = mealData.name
        meal.mealCategory = mealData.mealCategory
        meal.cuisine = mealData.cuisine
        meal.instructions = mealData.instructions
        
        // add all ingredients to meal
        for ingredientData in mealData.mealIngredients {
            // if valid ingredient
            if nilAndEmptyStringCheck(nameString: ingredientData.name, quantityString: ingredientData.quantity) {
                // create ingredientMeasurement object
                let newIngredient = addIngredientMeasurement(name: ingredientData.name!, quantity: ingredientData.quantity!)
                
                // add ingredient to meal - this should aways return true as it is a new meal object
                // being created from mealData
                let _ = addIngredientToMeal(ingredient: newIngredient, meal: meal)
            } else {
                // if empty or nil string encountered (nilAndEmptyStringCheck returns false
                // no other valid data will follow (due to JSON object structure, therfore
                // loop will break).
                break
            }
        }
        
        return meal
    }
    
    func passMeal(meal: Meal?) -> Meal {
        var childMeal: Meal?
        
        // if existing meal was passed
        if meal != nil {
            // set child context parent
            childContext.parent = meal?.managedObjectContext
            
            // create child with reference to parent (the passed meal object)
            childMeal = childContext.object(with: meal!.objectID) as? Meal
            
            // add data to child
            childMeal?.name = meal?.name
            childMeal?.mealCategory = meal?.mealCategory
            childMeal?.cuisine = meal?.cuisine
            childMeal?.instructions = meal?.instructions
            
        } else {
            // create empty child
            childContext.parent = persistentContainer.viewContext
            childMeal = NSEntityDescription.insertNewObject(forEntityName: "Meal", into: childContext) as? Meal
        }
        return childMeal!
    }
    
    func deleteMeal(meal: Meal) {
        persistentContainer.viewContext.delete(meal)
    }
    
    func fetchMealLibraryMeals() -> [Meal] {
        if allLibraryMealsFetchedResultsController == nil {
            // fetch request setup for meal data
            let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
            
            // ensure results are ordered my name and come from the 'My Meals' MealLibrary
            let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            let predicate = NSPredicate(format: "library.name == %@", DEFAULT_MEAL_LIBRARY_NAME)
            fetchRequest.sortDescriptors = [nameSortDescriptor]
            fetchRequest.predicate = predicate
            
            // initialise the fetch results controller
            allLibraryMealsFetchedResultsController = NSFetchedResultsController<Meal>(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            
            // set core data controller to be the results delegate
            allLibraryMealsFetchedResultsController?.delegate = self
            
            // perform the fetch request
            do {
                try allLibraryMealsFetchedResultsController?.performFetch()
            } catch {
                print("Failed Fetch Request: \(error)")
            }
        }
        
        // if any data is returned from fetch request, give that data. Else return an empty meal array
        if let meals = allLibraryMealsFetchedResultsController?.fetchedObjects {
            return meals
        }
        return [Meal]()
    }

    
    func fetchAllIngredients() -> [Ingredient] {
        if allIngredientsFetchedResultsController == nil {
            // fetch request setup for ingredient data
            let fetchRequest: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
            
            // ensure results are ordered my name
            let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [nameSortDescriptor]
            
            // initialise the fetch results controller
            allIngredientsFetchedResultsController = NSFetchedResultsController<Ingredient>(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            
            // set core data controller to be the results delegate
            allIngredientsFetchedResultsController?.delegate = self
            
            // perform the fetch request
            do {
                try allIngredientsFetchedResultsController?.performFetch()
            } catch {
                print("Failed Fetch Request: \(error)")
            }
        }
        
        // if any data is returned from fetch request, give that data. Else return an empty ingredient array
        if let ingredients = allIngredientsFetchedResultsController?.fetchedObjects {
            return ingredients
        }
        
        return [Ingredient]()
    }
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        listener.onLibraryChange(storedMeals: fetchMealLibraryMeals())
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
    
    func addMealLibrary(mealLibraryName: String) -> MealLibrary {
        // create mealLibrary object
        let mealLibrary = NSEntityDescription.insertNewObject(forEntityName: "MealLibrary", into: persistentContainer.viewContext) as! MealLibrary
        mealLibrary.name = mealLibraryName
        
        return mealLibrary
    }
    
    func deleteMealLibrary(mealLibrary: MealLibrary) {
        persistentContainer.viewContext.delete(mealLibrary)
    }
    
    func addMealToMealLibrary(meal: Meal, mealLibrary: MealLibrary) -> Bool {
        // check that meal is not already in mealLibrary
        guard let meals = mealLibrary.savedMeals?.allObjects as? [Meal], meals.contains(where: { savedMeal in
            savedMeal.name?.lowercased() == meal.name?.lowercased()
        }) == false else {
            return false
        }
        
        // add meal to mealLibrary
        mealLibrary.addToSavedMeals(meal)
        return true
    }
    
    func removeMealFromMealLibrary(meal: Meal, mealLibrary: MealLibrary) {
        mealLibrary.removeFromSavedMeals(meal)
    }
    
    func addIngredientMeasurement(name: String, quantity: String) -> IngredientMeasurement {
        // create ingredientMeasurement object
        let ingredientMeasurement = NSEntityDescription.insertNewObject(forEntityName: "IngredientMeasurement", into: persistentContainer.viewContext) as! IngredientMeasurement
        
        // set data
        ingredientMeasurement.name = name
        ingredientMeasurement.quantity = quantity
        
        return ingredientMeasurement
    }
    
    func deleteIngredientMeasurement(ingredientMeasurement: IngredientMeasurement) {
        persistentContainer.viewContext.delete(ingredientMeasurement)
    }
    
    func addIngredientToMeal(ingredient: IngredientMeasurement, meal: Meal) -> Bool {
        // check if ingredient has already been added to meal
        let ingredients = meal.ingredients?.allObjects as? [IngredientMeasurement]
        if ingredients!.contains(where: {savedIngredient in
            savedIngredient.name?.lowercased() == ingredient.name?.lowercased()
        }) {
            return false
        }
        
        meal.addToIngredients(ingredient)
        return true
    }
    
    func removeIngredientFromMeal(ingredient: IngredientMeasurement, meal: Meal) {
        meal.removeFromIngredients(ingredient)
    }
    
    
    func addIngredientData(ingredientData: IngredientData) -> Ingredient {
        let ingredient = NSEntityDescription.insertNewObject(forEntityName: "Ingredient", into: persistentContainer.viewContext) as! Ingredient
        
        // set ingredient data
        ingredient.name = ingredientData.name
        ingredient.ingredientDescription = ingredientData.ingredientDescription
        
        return ingredient
    }
    
    func nilAndEmptyStringCheck(nameString: String?, quantityString: String?) -> Bool {
        // check if both strings are valid
        return (nameString != nil && nameString != "") && (quantityString != nil && quantityString != "") ? true : false
    }
    
    // MARK: - Fetched Results Controller Protocol methods
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if controller == allLibraryMealsFetchedResultsController {
            listeners.invoke() { listener in
                listener.onLibraryChange(storedMeals: fetchMealLibraryMeals())
            }
        }
    }
    
    // MARK: - Lazy Initiliasation of 'My Meals' MealLibrary (currently the default mealLibrary)
    lazy var myMealLibrary: MealLibrary = {
        var mealLibraries = [MealLibrary]()
        
        // set up fetch request for mealLibrary data
        let request: NSFetchRequest<MealLibrary> = MealLibrary.fetchRequest()
        let predicate = NSPredicate(format: "name = %@", DEFAULT_MEAL_LIBRARY_NAME)
        request.predicate = predicate
        
        // perform fetch request
        do {
            try mealLibraries = persistentContainer.viewContext.fetch(request)
        } catch {
            print("Unable to fetch MealLibrary data: \(error)")
        }
        
        // check for already created custom mealLibraries otherwise give the default
        if let firstMealLibrary = mealLibraries.first {
            return firstMealLibrary
        }
        
        return addMealLibrary(mealLibraryName: DEFAULT_MEAL_LIBRARY_NAME)
    }()
    
}


 
