//
//  RecipeListTableViewCell.swift
//  RecipeBook
//
//  Created by Andrew Boyd on 30/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import UIKit

// Table View Cell for the Recipe List. Requirements were just to have the recipe title on this, but the image makes it look prettier.
class RecipeListTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Configuration
    func configure(with recipeData: RecipeListItemDataModel) {
        // Decode any HTML entities in the title before setting it
        self.titleLabel.text = recipeData.title.stringByDecodingHTMLEntities
        
        // If a thumbnail path is present, download and set the image
        if let thumbnailPath = recipeData.thumbnailPath {
            UIImage.downloadImage(at: thumbnailPath, completion: { (image) in
                OperationQueue.main.addOperation {
                    self.thumbnailImageView.image = image
                }
            })
        }
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        self.titleLabel.text = nil
        self.thumbnailImageView.image = UIImage(named: "placeholder_small")
    }
}
