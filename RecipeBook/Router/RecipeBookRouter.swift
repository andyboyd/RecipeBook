//
//  RecipeBookRouter.swift
//  RecipeBook
//
//  Created by Andrew Boyd on 29/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import Foundation
import UIKit

class RecipeBookRouter {
    
    // A function to create and configure a RecipeDetailViewController for the specified recipe.
    // Could be extended to return different types of views depending ont he recipe passed
    class func recipeDetailViewController(for recipe: RecipeDetailDataModel) -> RecipeDetailViewController? {
        guard let detailVC = UIStoryboard(name: "RecipeDetail", bundle: nil).instantiateInitialViewController() as? RecipeDetailViewController else {
            return nil
        }
        detailVC.configure(with: recipe)
        return detailVC
    }
    
}
