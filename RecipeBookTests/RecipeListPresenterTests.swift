//
//  RecipeListPresenterTests.swift
//  RecipeBookTests
//
//  Created by Andrew Boyd on 30/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import XCTest
@testable import RecipeBook

class RecipeListPresenterTests: XCTestCase {
    
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
    
    var testPresenter : RecipeListPresenter!
    
    override func setUp() {
        super.setUp()
        self.testPresenter = RecipeListPresenter()
        self.testPresenter.interactor = RecipeListInteractor()
        self.testPresenter.interactor.recipes = self.stubRecipes
    }
    
    // MARK: - recipeListItemData(at index:)
    func test_recipeListItemData_validIndex_returnsCorrectDataModel() {
        XCTAssertEqual(self.testPresenter.recipeListItemData(at: 1)!, RecipeListItemDataModel(title: "title 1", thumbnailPath: "thumbnail 1"))
    }
    
    func test_recipeListItemData_invalidIndex_returnsNil() {
        XCTAssertNil(self.testPresenter.recipeListItemData(at: 3))
    }
    
    // MARK: - recipeDetailData(at index:)
    func test_recipeDetailData_validIndex_returnsCorrectDataModel() {
        XCTAssertEqual(self.testPresenter.recipeDetailData(at: 2)!, RecipeDetailDataModel(title: "title 2", ingredients: "ingredients 2", link: URL(string: "http://somevalidurl.com")!, imagePath: nil))
    }
    
    func test_recipeDetailData_invalidIndex_returnsNil() {
        XCTAssertNil(self.testPresenter.recipeDetailData(at: 3))
    }
    
    func test_recipeDetailData_validIndex_invalidLink_returnsNil() {
        XCTAssertNil(self.testPresenter.recipeDetailData(at: 1))
    }
}
