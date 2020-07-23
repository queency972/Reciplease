//
//  SearchResultViewController.swift
//  Reciplease
//
//  Created by Steve Bernard on 06/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

// Search Result Interface
class SearchResultViewController: UIViewController {
    var hits = [Hit]()
    var selectedRecipe: Recipe?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Import XIB
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "recipeCell")
    }
    
    // Transition, data controller to controller (Prepare Seg)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeDetailVC = segue.destination as? RecipeDetailViewController else {return}
        recipeDetailVC.recipe = selectedRecipe
    }
}

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
        return 196
    }
    
    // Allowing to get information for the cell Selected from XIB.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = hits[indexPath.row].recipe
        
        // Run transition.
        performSegue(withIdentifier: "recipeDetail", sender: nil)
    }
}
