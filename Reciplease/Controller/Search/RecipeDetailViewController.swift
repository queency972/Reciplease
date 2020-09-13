//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Steve Bernard on 06/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

struct DetailIngredients {
    let title: String
    let time: String
    let ingredients: [String]
    let url: String
    let yield: String
    var image: String
}

class RecipeDetailViewController: UIViewController {

    var detailIngredients: DetailIngredients?
    var recipe: Recipe?
    var coreDataManager: CoreDataManager?

    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var getDirection: UIButton!
    @IBOutlet weak var favorisButton: UIBarButtonItem!
    @IBOutlet weak var yieldLabel: UILabel!

    @IBAction func addFavorisButton(_ sender: UIBarButtonItem) {
        let totalTime = detailIngredients!.time
        let yield = String(detailIngredients!.yield)
        if (coreDataManager?.isRecipeRegistered(title: detailIngredients!.title))! {
            favorisButton.tintColor = .white
            // Deleting recipe
            coreDataManager?.deleteRecipe(title: detailIngredients!.title)
        }
        else {
            favorisButton.tintColor = .yellow
            coreDataManager?.createRecipe(title: detailIngredients!.title, ingredients: detailIngredients!.ingredients, time: totalTime, url: detailIngredients!.url, yield: yield, image: (detailIngredients!.image))
        }
    }

    func setColorFavorite() {
        if (coreDataManager?.isRecipeRegistered(title: detailIngredients!.title))! {
            favorisButton.tintColor = .yellow
        } else {
            favorisButton.tintColor = .white
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setColorFavorite()
    }

    // Button allowing to access to webSite
    @IBAction func getDirectionButton(_ sender: UIButton) {
        guard let getDirection = detailIngredients?.url else {
            UIApplication.shared.open(URL(string: "https://www.edamam.com/404")!)
            return
        }
        UIApplication.shared.open(URL(string: getDirection)!)
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // On Recupere Appdelage ds l'application
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        // On recupere le CoreDataSt qui se trouve ds l'appdelegate
        let coredataStack = appdelegate.coreDataStack
        // On instancie le coreDataManager
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)

        recipeTitleLabel.text = detailIngredients?.title
        preparationTimeLabel.text =  detailIngredients!.time

        recipeImage.sd_setImage(with: URL(string: "\(detailIngredients?.image ?? "")"), placeholderImage: UIImage(named: "Cooking.png"))
        getDirection.setupGetDirectionButton()
        yieldLabel.text = "\(String(describing: detailIngredients!.yield)) yield(s)"
    }
}

// MARK: - TableView
extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {

    // number of line need
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (detailIngredients?.ingredients.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Modif withIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredients", for: indexPath)
        // Set cell with ingredientLines's array.
        cell.textLabel?.text = detailIngredients?.ingredients[indexPath.row]
        cell.textLabel?.font = UIFont(name:"Noteworthy", size:18)
        return cell
    }

    // Use heightForFooterInSection (line) if necessary
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (detailIngredients?.ingredients.isEmpty)! ? 50 : 1
    }
}
