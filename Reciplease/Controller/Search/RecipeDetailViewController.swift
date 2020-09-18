//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Steve Bernard on 06/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit
import SDWebImage

struct DetailIngredients {
    let title: String
    let time: String
    let ingredients: [String]
    let url: String
    let yield: String
    var image: Data?
}

final class RecipeDetailViewController: UIViewController {

    var detailIngredients: DetailIngredients?
    private var coreDataManager: CoreDataManager?
    var comeFromFavorite: Bool = false 

    // MARK: - Oulets
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var getDirection: UIButton!
    @IBOutlet weak var favorisButton: UIBarButtonItem!
    @IBOutlet weak var yieldLabel: UILabel!

    // MARK: - Funtions
    @IBAction func addFavorisButton(_ sender: UIBarButtonItem) {
        guard let totalTime = detailIngredients?.time else {return}
        guard let yield = detailIngredients?.yield else {return}
        guard let title = detailIngredients?.title else {return}
        guard let url = detailIngredients?.url else {return}
        guard let image = detailIngredients?.image else {return}
        guard let ingredients = detailIngredients?.ingredients else {return}

        guard let isRecipeRegistred = coreDataManager?.isRecipeRegistered(title: title) else {return}
        if (isRecipeRegistred) {
            favorisButton.tintColor = .white
            // Deleting recipe
            coreDataManager?.deleteRecipe(title: title)
            if comeFromFavorite {
                navigationController?.popViewController(animated: true)
            }
        }
        else {
            favorisButton.tintColor = .yellow
            coreDataManager?.createRecipe(title: title, ingredients: ingredients, time: totalTime, url: url, yield: yield, image: (image))
        }
    }

    func setColorFavorite() {
        guard let title = detailIngredients?.title else {return}
        guard let isRecipeRegistered = coreDataManager?.isRecipeRegistered(title: title) else {return}
        if (isRecipeRegistered) {
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
        guard let urlError = URL(string: "https://www.edamam.com/404") else {return}
        guard let getDirection = detailIngredients?.url else {
            UIApplication.shared.open(urlError)
            return
        }
        guard let getUrl = URL(string: getDirection) else {return}
        UIApplication.shared.open(getUrl)
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
        setInterface()
    }

    func setInterface() {
        recipeTitleLabel.text = detailIngredients?.title
        guard let totalTime = detailIngredients?.time else {return}
        preparationTimeLabel.text = totalTime
        recipeImage.image = detailIngredients?.image?.uiImage
        getDirection.setupGetDirectionButton()
        guard let yield = detailIngredients?.yield else {return}
        yieldLabel.text = "\(String(describing: yield)) yield(s)"
    }
}

// MARK: - TableView
extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {

    // number of line need
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ingredient = detailIngredients?.ingredients
        return ingredient?.count ?? 0
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
