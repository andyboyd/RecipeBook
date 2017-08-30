//
//  RecipeDetailDataModelTests.swift
//  RecipeBookTests
//
//  Created by Andrew Boyd on 30/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import XCTest
@testable import RecipeBook

class RecipeDetailDataModelTests: XCTestCase {
    
    let validURL = URL(string: "http://valid.com")!
    
    // MARK: - == Operator
    func test_isEqual_selfEqualsSelf() {
        let testItem = RecipeDetailDataModel(title: "title", ingredients: "ingredients", link: validURL, imagePath: "image")
        
        XCTAssertEqual(testItem, testItem)
    }
    
    func test_isEqual_equalProperties_returnsTrue() {
        let testItem1 = RecipeDetailDataModel(title: "title", ingredients: "ingredients", link: validURL, imagePath: "image")
        let testItem2 = RecipeDetailDataModel(title: "title", ingredients: "ingredients", link: validURL, imagePath: "image")
        
        XCTAssertEqual(testItem1, testItem2)
    }
    
    func test_isEqual_differentProperties_returnsFalse() {
        let testItem1 = RecipeDetailDataModel(title: "title", ingredients: "ingredients", link: validURL, imagePath: "image")
        let testItem2 = RecipeDetailDataModel(title: "title2", ingredients: "ingredients2", link: validURL, imagePath: "image2")
        
        XCTAssertNotEqual(testItem1, testItem2)
    }
    
    func test_isEqual_selfEqualsNil_returnsFalse() {
        let testItem = RecipeDetailDataModel(title: "title", ingredients: "ingredients", link: validURL, imagePath: "image")
        
        XCTAssertNotEqual(testItem, nil)
    }
    
    func test_isEqual_allEqualExceptImageIsNil_returnsFalse() {
        let testItem1 = RecipeDetailDataModel(title: "title", ingredients: "ingredients", link: validURL, imagePath: "image")
        let testItem2 = RecipeDetailDataModel(title: "title", ingredients: "ingredients", link: validURL, imagePath: nil)
        
        XCTAssertNotEqual(testItem1, testItem2)
    }
    
}
