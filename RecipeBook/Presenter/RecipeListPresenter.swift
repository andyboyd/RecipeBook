//
//  RecipeListPresenter.swift
//  RecipeBook
//
//  Created by Andrew Boyd on 29/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import Foundation

// Data struct to be created for each row on the recipe list table
struct RecipeListItemDataModel: Equatable {
    let title: String
    let thumbnailPath: String?
    
    static func ==(lhs: RecipeListItemDataModel, rhs: RecipeListItemDataModel) -> Bool {
        return lhs.title == rhs.title && lhs.thumbnailPath == rhs.thumbnailPath
    }
}

// Data struct to provide information for a recipe detail page.
// We could just use the RecipeEntity itself instead of this,
// but I wanted the presenter to do a bit of checking and guarantee that the link is a valid URL
struct RecipeDetailDataModel: Equatable {
    let title: String
    let ingredients: String
    let link: URL
    let imagePath: String?
    
    static func ==(lhs: RecipeDetailDataModel, rhs: RecipeDetailDataModel) -> Bool {
        return lhs.title == rhs.title && lhs.ingredients == rhs.ingredients && lhs.link == rhs.link && lhs.imagePath == rhs.imagePath
    }
}

// Presenter class for the recipe List.
// Responsible for asking the Interactor for data and converting it into forms that can be used by the View.
class RecipeListPresenter {
    
    // The interactor used to interface witht he data.
    // I really want this to be private, but that makes it tricky to test.
    var interactor = RecipeListInteractor()
    
    // Asks the RecipeListInteractor for recipes matching the specified search query.
    func updateRecipes(for searchQuery: String?, completion: @escaping () -> Void) {
        self.interactor.getRecipes(for: searchQuery ?? "") {
            completion()
        }
    }
    
    // Returns the number of recipes in the current list
    func numberOfRecipes() -> Int {
        return self.interactor.numberOfRecipes()
    }
    
    // Returns Recipe List Item Data for the specified index, or nil if the index is out of scope
    func recipeListItemData(at index: Int) -> RecipeListItemDataModel? {
        guard let recipe = self.interactor.recipe(at: index) else {
            return nil
        }
        
        return RecipeListItemDataModel(title: recipe.title,
                                       thumbnailPath: recipe.thumbnailPath)
    }
    
    // Returns Recipe Detail Data for the specified index, or nil if the index is out of scope,
    // or if the data is invalid (i.e. it does not have a valid URL)
    func recipeDetailData(at index: Int) -> RecipeDetailDataModel? {
        guard let recipe = self.interactor.recipe(at: index) else {
            return nil
        }
        
        guard let linkURL = URL(string: recipe.link) else {
            print("recipe link was not a valid URL")
            return nil
        }
        
        return RecipeDetailDataModel(title: recipe.title,
                                     ingredients: recipe.ingredients,
                                     link: linkURL,
                                     imagePath: recipe.thumbnailPath)
    }
}
