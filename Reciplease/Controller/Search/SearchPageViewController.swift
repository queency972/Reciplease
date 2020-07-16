//
//  SearchPageViewController.swift
//  Reciplease
//
//  Created by Steve Bernard on 05/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit
import SDWebImage

class SearchPageViewController: UIViewController {
    
    let userIngredient = UserIngredient()
    let recipe = RecipeService()
    var hits = [Hit]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func clearIngredientButton(_ sender: UIButton) {
        userIngredient.resetIngredients()
        tableView.reloadData()
    }
    
    // MARK: - Public Methods
    
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
    
    // Run call network to get recipes.
    @IBAction func searchForRecipes(_ sender: UIButton) {
        guard !userIngredient.allIngredients.isEmpty else {
            presentAlert(title: "Oups", message: "Please enter an ingredient !")
            return
        }
        recipe.getRecipe(ingredientsFormatted: userIngredient.ingredientsString) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.hits = data.hits
                    // Lancement de la transition.
                    self?.performSegue(withIdentifier: "segueToSucces", sender: nil)
                case .failure(_):
                    self?.presentAlert(title: "Connection error", message: "")
                }
            }
        }
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
        userIngredient.allIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.text = userIngredient.allIngredients[indexPath.row]
        cell.textLabel?.font = UIFont(name:"Noteworthy", size:22)
        return cell
    }
    
    // Use heightForFooterInSection (line) if necessary
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return userIngredient.allIngredients.isEmpty ? 50 : 1
    }
}



