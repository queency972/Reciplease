//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Steve Bernard on 09/07/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit
import SDWebImage

// Set interface
class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var favorisButton: UIButton!

    var ingredient = UserIngredient()
    var listIngredient: Recipes?
    var coreDataStack = CoreDataStack()

    // Set interface
    var recipe: Recipe? {
        didSet {
            titleLabel.text = recipe?.label
            // detailLabel.text = "\(String(describing: ingredient.allIngredients))"
            preparationTimeLabel.text = "\(String(describing: recipe!.totalTime)) min(s)"
            recipeImage.sd_setImage(with: URL(string: "\(recipe?.image ?? "")"), placeholderImage: UIImage(named: "Cooking.png"))
        }
    }

    @IBAction func addFavoris(_ sender: UIButton) {
        colorFavoris()
        let ingredient = AllIngredient(context: coreDataStack.mainContext)
        //ingredient.ingredient =
        //try? coreDataStack.mainContext.save()
    }

    func  colorFavoris() -> UIButton {
        let favorisImage = favorisButton

        if favorisImage?.tintColor == .black {
            favorisImage?.tintColor = .yellow
        } else {
            favorisImage?.tintColor = .black
        }
        return favorisImage!
    }
}
