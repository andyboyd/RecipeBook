//
//  RecipeListViewController.swift
//  RecipeBook
//
//  Created by Andrew Boyd on 29/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import UIKit

// Main View Controller class for the searchable recipe list
class RecipeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet private weak var searchField: UITextField!
    @IBOutlet private weak var recipeTable: UITableView!
    
    // The presenter belonging to the Recipe List View
    private let presenter : RecipeListPresenter = RecipeListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make tableview cells self sizing
        self.recipeTable.rowHeight = UITableViewAutomaticDimension
        self.recipeTable.estimatedRowHeight = 70
        
        // Add target to respond to text changes in search field.
        // Note: Didn't use an actual search controller for this because I find it works best
        // when searching an offline data source versus making new requests to an API.
        // Plus I don't like the way the UI looks :)
        searchField.addTarget(self, action: #selector(RecipeListViewController.searchFieldChanged), for: UIControlEvents.editingChanged)
        
        // Listen for notifications when keyboard is shown/hidden so we can adjust the tableview scroll insets
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RecipeListViewController.keyboardDidShowOrHide(_:)),
                                               name: .UIKeyboardDidShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RecipeListViewController.keyboardDidShowOrHide(_:)),
                                               name: .UIKeyboardDidHide,
                                               object: nil)
        
        // Initially show a list of recipes with no search term specified
        self.presenter.updateRecipes(for: nil) { [weak self] in
            OperationQueue.main.addOperation {
                self?.recipeTable.reloadData()
            }
        }
    }
    
    deinit {
        // Remove observers
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfRecipes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as? RecipeListTableViewCell else {
            fatalError("Could not dequeue correct type of cell, something's gone horribly wrong!")
        }
        
        guard let recipeData = self.presenter.recipeListItemData(at: indexPath.row) else {
            fatalError("Could not fetch recipe data for this index")
        }
        
        cell.configure(with: recipeData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the detail VC from the router.
        guard let recipeDetailData = self.presenter.recipeDetailData(at: indexPath.row),
        let detailVC = RecipeBookRouter.recipeDetailViewController(for: recipeDetailData) else {
            // It's possible the Presenter would be unable to initialise Recipe Detail Data if the link was not a valid URL.
            // If that happens, the user will just see the cell flashing and nothing else would happen.
            // We could pop up an alert, but for now I'm working on the assumption that an
            // invalid link is a problem with the API, so shouldn't ever happen.
            return
        }
        
        // Deselect the row again to make it look better when navigating back to the list
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Push the VC onto the Navigation stack
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Text Field
    
    @objc func searchFieldChanged() {
        // This could be optimised by, for example, only sending the request if the user stops typing for 0.2s,
        // To avoid spamming the API when the user types quickly.
        // However, in my testing the API was extremely fast to respond,
        // so it wasn't necessary to deliver a fluid user experience
        self.presenter.updateRecipes(for: self.searchField.text) { [weak self] in
            OperationQueue.main.addOperation {
                self?.recipeTable.reloadData()
            }
        }
    }
    
    // MARK: - Keyboard scroll insets
    // Make sure the user can scroll to the bottom of the table when the keyboard is displayed.
    @objc func keyboardDidShowOrHide(_ notification: NSNotification) {
        guard let keyboardEndFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        self.recipeTable.contentInset = UIEdgeInsetsMake(0, 0, keyboardEndFrame.size.height, 0)
    }
}

