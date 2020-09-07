//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Steve Bernard on 06/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

struct Details {
    let title: String
    let time: String
    let ingredients: [String]
    let url: String
    let yield: String
    let image: Data
}

class RecipeDetailViewController: UIViewController {

    var detail: Details?
    var recipe: Recipe?
    var coreDataManager: CoreDataManager?

    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var getDirection: UIButton!
    @IBOutlet weak var favorisButton: UIBarButtonItem!
    @IBOutlet weak var yieldLabel: UILabel!

    @IBAction func addFavorisButton(_ sender: UIBarButtonItem) {
        let totalTime = String(recipe!.totalTime)
        let yield = String(recipe!.yield)
        if (coreDataManager?.isRecipeRegistered(title: recipe!.label))! {
            favorisButton.tintColor = .white
            coreDataManager?.deleteRecipe(title: recipe!.label)
        } else {
            favorisButton.tintColor = .yellow
            coreDataManager?.createRecipe(title: recipe!.label, ingredients: recipe!.ingredientLines, time: totalTime, url: recipe!.shareAs, yield: yield, image: recipe!.image.data)
        }
    }

    func setColorFavorite() {
        if (coreDataManager?.isRecipeRegistered(title: recipe!.label))! {
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
        guard let getDirection = recipe?.shareAs else {
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

        recipeTitleLabel.text = recipe?.label
        let seconde: Int = 60

        if recipe!.totalTime < seconde {
            preparationTimeLabel.text = "\(String(describing: recipe!.totalTime))s"
        }
        else {
            preparationTimeLabel.text = "\(recipe!.totalTime.timeInSecondsToString)m"
        }
        recipeImage.sd_setImage(with: URL(string: "\(recipe?.image ?? "")"), placeholderImage: UIImage(named: "Cooking.png"))
        getDirection.setupGetDirectionButton()
        yieldLabel.text = "\(String(describing: recipe!.yield)) yield(s)"
    }
}

// MARK: - TableView
extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {

    // numberof line need
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipe?.ingredientLines.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Modif withIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredients", for: indexPath)
        // Set cell with ingredientLines's array.
        cell.textLabel?.text = recipe?.ingredientLines[indexPath.row]
        cell.textLabel?.font = UIFont(name:"Noteworthy", size:18)
        return cell
    }

    // Use heightForFooterInSection (line) if necessary
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (recipe?.ingredientLines.isEmpty)! ? 50 : 1
    }
}
