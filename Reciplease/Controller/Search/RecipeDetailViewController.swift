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
    var image: String // Data?
}

final class RecipeDetailViewController: UIViewController {

    var detailIngredients: DetailIngredients?
    private var coreDataManager: CoreDataManager?

    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var getDirection: UIButton!
    @IBOutlet weak var favorisButton: UIBarButtonItem!
    @IBOutlet weak var yieldLabel: UILabel!

    @IBAction func addFavorisButton(_ sender: UIBarButtonItem) {
        guard let totalTime = detailIngredients?.time else {return}
        guard let yield = detailIngredients?.yield else {return}
        guard let title = detailIngredients?.title else {return}
        guard let url = detailIngredients?.url else {return}
        guard let image = detailIngredients?.image else {return}
        guard let ingredients = detailIngredients?.ingredients else {return}

        if (coreDataManager?.isRecipeRegistered(title: title))! { // A deb...
            favorisButton.tintColor = .white
            // Deleting recipe
            coreDataManager?.deleteRecipe(title: title)
        }
        else {
            favorisButton.tintColor = .yellow
            coreDataManager?.createRecipe(title: title, ingredients: ingredients, time: totalTime, url: url, yield: yield, image: (image))
        }
        navigationController?.popViewController(animated: true)
    }

    func setColorFavorite() {
        guard let title = detailIngredients?.title else {return}
        if (coreDataManager?.isRecipeRegistered(title: title))! { // A debal...
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
            UIApplication.shared.open(URL(string: "https://www.edamam.com/404")!) // deb...
            return
        }
        UIApplication.shared.open(URL(string: getDirection)!) // deb...
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

        // A metttre ds une func.
        recipeTitleLabel.text = detailIngredients?.title
        guard let totalTime = detailIngredients?.time else {return}
        preparationTimeLabel.text = totalTime

        recipeImage.sd_setImage(with: URL(string: "\(detailIngredients?.image ?? "")"), placeholderImage: UIImage(named: "Cooking.png"))
        getDirection.setupGetDirectionButton()
        guard let yield = detailIngredients?.yield else {return}
        yieldLabel.text = "\(String(describing: yield)) yield(s)"
    }
}

// MARK: - TableView
extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {

    // number of line need
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (detailIngredients?.ingredients.count)! // A deb..
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
        return (detailIngredients?.ingredients.isEmpty)! ? 0 : 1
    }
}
