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

    var recipe: Recipe?
    var selectedRecipe: Recipe?

    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var getDirection: UIButton!

    // Button allowing to access to webSite
    @IBAction func getDirectionButton(_ sender: UIButton) {
        guard let getDirection = recipe?.shareAs else {
               UIApplication.shared.open(URL(string: "https://www.edamam.com/404")!)
               return
           }
           UIApplication.shared.open(URL(string: getDirection)!)
    }

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTitleLabel.text = recipe?.label
        preparationTimeLabel.text = "\(String(describing: recipe!.totalTime)) min(s)"
        recipeImage.sd_setImage(with: URL(string: "\(recipe?.image ?? "")"), placeholderImage: UIImage(named: "Cooking.png"))
        setupGetDirectionButton()
    }

    // Setup button
    func setupGetDirectionButton() {
        getDirection.layer.cornerRadius = 5
        getDirection.layer.borderWidth = 1
        getDirection.layer.borderColor = UIColor.black.cgColor
    }
}

// MARK: - TableView
extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {

    // numberof line need
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (recipe?.ingredientLines.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredients", for: indexPath)
        cell.textLabel?.text = recipe?.ingredientLines[indexPath.row]
        cell.textLabel?.font = UIFont(name:"Noteworthy", size:18)
        return cell
    }

    // Use heightForFooterInSection (line) if necessary
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (recipe?.ingredientLines.isEmpty)! ? 50 : 1
    }
}
