//
//  RecipeListInteractorTests.swift
//  RecipeBookTests
//
//  Created by Andrew Boyd on 30/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import XCTest
@testable import RecipeBook

class RecipeListInteractorTests: XCTestCase {
    
    let stubRecipes = [RecipeEntity(title: "title 0",
                                    link: "link 0",
                                    ingredients: "ingredients 0",
                                    thumbnailPath: "thumbnail 0"),
                       RecipeEntity(title: "title 1",
                                    link: "link 1",
                                    ingredients: "ingredients 1",
                                    thumbnailPath: "thumbnail 1"),
                       RecipeEntity(title: "title 2",
                                    link: "http://somevalidurl.com",
                                    ingredients: "ingredients 2",
                                    thumbnailPath: nil)]
    
    var testInteractor : RecipeListInteractor!
    
    override func setUp() {
        super.setUp()
        self.testInteractor = RecipeListInteractor()
        self.testInteractor.recipes = self.stubRecipes
    }
    
    // MARK: - numberOfRecipes()
    func test_numberOfRecipes_returnsCorrectNumber() {
        XCTAssertEqual(self.testInteractor.numberOfRecipes(), 3)
    }
    
    func test_numberOfRecipes_nilRecipes_returnsZero() {
        self.testInteractor.recipes = nil
        XCTAssertEqual(self.testInteractor.numberOfRecipes(), 0)
    }
    
    // MARK: - recipe(at index:)
    func test_recipeAtIndex_validIndex_returnsCorrctRecipe() {
        XCTAssertEqual(self.testInteractor.recipe(at: 1), self.stubRecipes[1])
    }
    
    func test_recipeAtIndex_invalidIndex_returnsNil() {
        XCTAssertNil(self.testInteractor.recipe(at: 3))
    }
    
    func test_recipeAtIndex_nilRecipes_returnsNil() {
        self.testInteractor.recipes = nil
        XCTAssertNil(self.testInteractor.recipe(at: 0))
    }
}
