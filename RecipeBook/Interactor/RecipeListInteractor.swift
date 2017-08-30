//
//  RecipeListInteractor.swift
//  RecipeBook
//
//  Created by Andrew Boyd on 29/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import Foundation

// An Interactor class to parse JSON returned from the API into Entity objects
class RecipeListInteractor {
    
    // The list of recipe Entitites parsed fromt he last network request.
    // I really want this to be private, but that makes it trickey to test.
    var recipes: [RecipeEntity]?
    
    // Asynchronously returns a list of RecipeEntities matching the specified search text
    func getRecipes(for searchText: String,
                          completion: @escaping () -> Void) {
        NetworkManager.getRecipes(for: searchText, success: { (json) in
            guard let results = json["results"] as? [[String: String]] else {
                print("JSON did not contain results array")
                return
            }
            
            var recipes: [RecipeEntity] = []
            for result in results {
                guard let title = result["title"],
                    let link = result["href"],
                    let ingredients = result["ingredients"] else {
                        print("malformed recipe in array")
                        break
                }
                
                let recipe = RecipeEntity(title: title,
                                          link: link,
                                          ingredients: ingredients,
                                          thumbnailPath: result["thumbnail"])
                
                recipes.append(recipe)
            }
            
            self.recipes = recipes
            completion()
                                    
        }) { (error) in
            // Could return these errors via a failure block so we could display an error to the user,
            // but printing to the console will do for now. The user will just see no changes.
            print(String(describing: error))
        }
    }
    
    func numberOfRecipes() -> Int {
        return self.recipes?.count ?? 0
    }
    
    func recipe(at index: Int) -> RecipeEntity? {
        guard let recipes = self.recipes, index < recipes.count else {
            return nil
        }
        
        return recipes[index]
    }
}
