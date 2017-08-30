//
//  RecipeListItemDataModelTests.swift
//  RecipeBookTests
//
//  Created by Andrew Boyd on 30/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import XCTest
@testable import RecipeBook

class RecipeListItemDataModelTests: XCTestCase {
    
    // MARK: - == Operator
    func test_isEqual_selfEqualsSelf() {
        let testItem = RecipeListItemDataModel(title: "title", thumbnailPath: "thumb")
        
        XCTAssertEqual(testItem, testItem)
    }
    
    func test_isEqual_equalProperties_returnsTrue() {
        let testItem1 = RecipeListItemDataModel(title: "title", thumbnailPath: "thumb")
        let testItem2 = RecipeListItemDataModel(title: "title", thumbnailPath: "thumb")
        
        XCTAssertEqual(testItem1, testItem2)
    }
    
    func test_isEqual_differentProperties_returnsFalse() {
        let testItem1 = RecipeListItemDataModel(title: "title1", thumbnailPath: "thumb1")
        let testItem2 = RecipeListItemDataModel(title: "title2", thumbnailPath: "thumb2")
        
        XCTAssertNotEqual(testItem1, testItem2)
    }
    
    func test_isEqual_selfEqualsNil_returnsFalse() {
        let testItem = RecipeListItemDataModel(title: "title", thumbnailPath: "thumb")
        
        XCTAssertNotEqual(testItem, nil)
    }
    
    func test_isEqual_allEqualExceptThumbnailIsNil_returnsFalse() {
        let testItem1 = RecipeListItemDataModel(title: "title", thumbnailPath: "thumb")
        let testItem2 = RecipeListItemDataModel(title: "title", thumbnailPath: nil)
        
        XCTAssertNotEqual(testItem1, testItem2)
    }
}
