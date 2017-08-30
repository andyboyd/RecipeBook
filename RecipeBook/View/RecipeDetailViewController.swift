//
//  RecipeDetailViewController.swift
//  RecipeBook
//
//  Created by Andrew Boyd on 30/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import UIKit

// View Controller to display details of a selected recipe
class RecipeDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    // Making outlets private so the VC has sole responsibility for modifying them
    @IBOutlet private weak var recipeNameLabel: UILabel!
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var ingredientsLabel: UILabel!
    
    // The Recipe Detail Data Model used to populate the UI.
    // Optional for safety, but should be configured by the Router before presenting the view
    private var recipe: RecipeDetailDataModel?
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The router should call configure(with recipe:) before the view gets presented, so this should always succeed
        if let recipe = self.recipe {
            
            // Set the text, decoding any ugly HTML entities that are present
            self.recipeNameLabel.text = recipe.title.stringByDecodingHTMLEntities
            self.ingredientsLabel.text = recipe.ingredients.stringByDecodingHTMLEntities
            
            // If there is an image, download it, otherwise the default placeholder will remain
            if let imagePath = recipe.imagePath {
                UIImage.downloadImage(at: imagePath, completion: { [weak self] (image) in
                    OperationQueue.main.addOperation {
                        self?.recipeImageView.image = image
                    }
                })
            }
        }
    }
    
    // The Router shoudl call this to properly initialize the VC before passing it on to the View layer for presentation
    func configure(with recipe: RecipeDetailDataModel) {
        self.recipe = recipe
    }
    
    // MARK: - IBActions
    @IBAction private func viewRecipeButtonTapped(_ sender: Any) {
        guard let url = self.recipe?.link else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
