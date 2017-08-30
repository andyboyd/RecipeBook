//
//  RecipeEntityTests.swift
//  RecipeBookTests
//
//  Created by Andrew Boyd on 30/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import XCTest
@testable import RecipeBook

class RecipeEntityTests: XCTestCase {
    
    // MARK: - == Operator
    func test_isEqual_selfEqualsSelf() {
        let testItem = RecipeEntity(title: "title", link: "link", ingredients: "ingredients", thumbnailPath: "thumb")
        XCTAssertEqual(testItem, testItem)
    }
    
    func test_isEqual_equalProperties_returnsTrue() {
        let testItem1 = RecipeEntity(title: "title", link: "link", ingredients: "ingredients", thumbnailPath: "thumb")
        let testItem2 = RecipeEntity(title: "title", link: "link", ingredients: "ingredients", thumbnailPath: "thumb")
        
        XCTAssertEqual(testItem1, testItem2)
    }
    
    func test_isEqual_differentProperties_returnsFalse() {
        let testItem1 = RecipeEntity(title: "title", link: "link", ingredients: "ingredients", thumbnailPath: "thumb")
        let testItem2 = RecipeEntity(title: "title2", link: "link2", ingredients: "ingredients2", thumbnailPath: "thumb2")
        
        XCTAssertNotEqual(testItem1, testItem2)
    }
    
    func test_isEqual_selfEqualsNil_returnsFalse() {
        let testItem = RecipeEntity(title: "title", link: "link", ingredients: "ingredients", thumbnailPath: "thumb")
        
        XCTAssertNotEqual(testItem, nil)
    }
    
    func test_isEqual_allEqualExceptImageIsNil_returnsFalse() {
        let testItem1 = RecipeEntity(title: "title", link: "link", ingredients: "ingredients", thumbnailPath: "thumb")
        let testItem2 = RecipeEntity(title: "title", link: "link", ingredients: "ingredients", thumbnailPath: nil)
        
        XCTAssertNotEqual(testItem1, testItem2)
    }
    
}
