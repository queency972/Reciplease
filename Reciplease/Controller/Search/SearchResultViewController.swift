//
//  SearchResultViewController.swift
//  Reciplease
//
//  Created by Steve Bernard on 06/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

// Search Result Interface
final class SearchResultViewController: UIViewController {

    // MARK: - Properties
    var hits = [Hit]()
    private var selectedRecipe: Recipe?

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Import XIB (Create class of Xib)
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "recipeCell")
    }
    
    // Transition, data controller to controller (Prepare Seg)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeDetailVC = segue.destination as? RecipeDetailViewController else {return}

        guard let title = selectedRecipe?.label else {return}
        guard let time = selectedRecipe?.totalTime else {return}
        guard let ingredients = selectedRecipe?.ingredientLines else {return}
        guard let url = selectedRecipe?.shareAs else {return}
        guard let yield = selectedRecipe?.yield else {return}
        guard let image = selectedRecipe?.image else {return}

        let networkDetailIngredients = DetailIngredients(title: title, time: time.timeInSecondsToString, ingredients: ingredients, url: url, yield: String(yield), image: image.data)
        
        recipeDetailVC.detailIngredients = networkDetailIngredients
        recipeDetailVC.comeFromFavorite = false
    }
}

// MARK: - Extension

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell
        cell.recipe = hits[indexPath.row].recipe
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    // Allowing to get information for the cell Selected from XIB.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = hits[indexPath.row].recipe
        // Run transition.
        performSegue(withIdentifier: "recipeDetail", sender: nil)
    }
}
