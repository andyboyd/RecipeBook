//
//  RecipeEntity.swift
//  RecipeBook
//
//  Created by Andrew Boyd on 29/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import Foundation

// Just a struct to contain the raw data that is passed by the API
struct RecipeEntity: Equatable {
    let title: String
    let link: String
    let ingredients: String
    let thumbnailPath: String?
    
    static func ==(lhs: RecipeEntity, rhs: RecipeEntity) -> Bool {
        return lhs.title == rhs.title && lhs.link == rhs.link && lhs.ingredients == rhs.ingredients && lhs.thumbnailPath == rhs.thumbnailPath
    }
}
