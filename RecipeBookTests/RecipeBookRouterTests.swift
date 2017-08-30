//
//  RecipeBookRouterTests.swift
//  RecipeBookTests
//
//  Created by Andrew Boyd on 30/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import XCTest
@testable import RecipeBook

class RecipeBookRouterTests: XCTestCase {
    let validRecipeDetailData = RecipeDetailDataModel(title: "recipe title",
                                                      ingredients: "recipe ingredients",
                                                      link: URL(string: "http://someurl.com")!,
                                                      imagePath: "http://someImagePath")
    
    func test_recipeDetailViewController_returnsRecipeDetailViewController() {
        let testVC = RecipeBookRouter.recipeDetailViewController(for: self.validRecipeDetailData)
        
        XCTAssertNotNil(testVC)
    }
}
