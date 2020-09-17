//
//  SearchPageViewController.swift
//  Reciplease
//
//  Created by Steve Bernard on 05/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

// Search Page Interface
final class SearchPageViewController: UIViewController {

    // MARK: - Properties
    private let userIngredient = UserIngredient()
    private let recipe = RecipeService()
    private var hits = [Hit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGetDirectionButton()
        activityIndicator.isHidden = true
    }

    // MARK: - Outlets
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchForRecipes: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
     // MARK: - Functions
    @IBAction func clearIngredientButton(_ sender: UIButton) {
        userIngredient.resetIngredients()
        // Allowing to reload TableView
        tableView.reloadData()
    }
    
    // Dismiss the keyboard
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        tableView.resignFirstResponder()
    }
    
    // Allowing to add ingredient in the list.
    @IBAction func addIngredientButton(_ sender: UIButton) {
        // Check if inputIngredient is not empty.
        guard let inputIngredient = ingredientTextField.text, !inputIngredient.isEmpty else {
            presentAlert(title: "Error", message: "Please, must type an ingredient")
            return
        }
        // Check if inputIngredient does not contain special Characters.
        guard !inputIngredient.specialCharacter else {
            presentAlert(title: "Error", message: "The text shouldn't contain any special character")
            return
        }
        userIngredient.addIngredient(inputIngredient)
        tableView.reloadData()
        ingredientTextField.text = ""
    }
    
    @objc func recipesLoaded(recipe: Bool) {
        if recipe == true {
            activityIndicator.isHidden = true
            searchForRecipes.isHidden = false
        } else {
            activityIndicator.isHidden = false
            searchForRecipes.isHidden = true
        }
    }
    
    // Run call network to get recipes.
    @IBAction func searchForRecipes(_ sender: UIButton) {
        recipesLoaded(recipe: false)
        guard !userIngredient.allIngredients.isEmpty else {
            presentAlert(title: "Oups", message: "Please enter an ingredient !")
            recipesLoaded(recipe: true)
            return
        }
        recipe.getRecipe(ingredientsFormatted: userIngredient.ingredientsString) { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.hits = data.hits
                    self?.recipesLoaded(recipe: true)
                    // Run transition.
                    self?.performSegue(withIdentifier: "segueToSucces", sender: nil)
                case .failure(_):
                    self?.presentAlert(title: "Connection error", message: "")
                }
            }
        }
    }
    
    // Setup button
    func setupGetDirectionButton() {
        searchForRecipes.layer.cornerRadius = 5
        searchForRecipes.layer.borderWidth = 1
        searchForRecipes.layer.borderColor = UIColor.black.cgColor
    }
    
    // Transition, data controller to controller (Prepare Seg)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let searchResultVC = segue.destination as? SearchResultViewController else {return}
        searchResultVC.hits = hits
    
    }
}

// MARK: - TableView
extension SearchPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userIngredient.allIngredients.count == 0 {
              tableView.setEmptyMessage("Add your ingredient !")
          } else {
              self.tableView.restore()
          }
        return  userIngredient.allIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.text = "- \(userIngredient.allIngredients[indexPath.row])"
        cell.textLabel?.font = UIFont(name:"Noteworthy", size:22)
        return cell
    }
    
    // Use height For Footer In Section (line) if necessary
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return userIngredient.allIngredients.isEmpty ? 0 : 1
    }

    // remove ingredient at index
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
            userIngredient.removeIngredient(at: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .automatic)
         }
     }
}
