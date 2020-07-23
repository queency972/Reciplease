//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Steve Bernard on 06/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

//
class RecipeDetailViewController: UIViewController {






    var recipe: Recipe!
    @IBOutlet weak var tableView: UITableView!

        override func viewDidLoad() {
            super.viewDidLoad()
            print(recipe)
        }

    var recipes: Recipe? {
        didSet {
            //titleLabel.text = recipe?.label
            //detailLabel.text = "\(String(describing: ingredient.allIngredients))"
           //preparationTimeLabel.text = "\(String(describing: recipe!.totalTime)) mins"
            //recipeImage.sd_setImage(with: URL(string: "\(recipe?.image ?? "")"), placeholderImage: UIImage(named: "Cooking.png"))
        }
    }
}

    // MARK: - TableView
    extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {

        // numberof line need
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            recipe.ingredientLines.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredients", for: indexPath)
            cell.textLabel?.text = recipe.ingredientLines[indexPath.row]
            cell.textLabel?.font = UIFont(name:"Noteworthy", size:18)
            return cell
        }

        // Use heightForFooterInSection (line) if necessary
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return recipe.ingredientLines.isEmpty ? 50 : 1
        }
    }
