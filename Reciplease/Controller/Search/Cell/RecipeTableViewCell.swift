//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Steve Bernard on 09/07/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit
import SDWebImage

// Set interface.
class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var favorisImage: UIImageView!

    var ingredient = UserIngredient()


    var recipe: Recipe? {
        didSet {
            titleLabel.text = recipe?.label
            detailLabel.text = "\(ingredient.ingredientsString)"
            preparationTimeLabel.text = "\(String(describing: recipe!.totalTime)) mins"
            recipeImage.sd_setImage(with: URL(string: "\(recipe?.image ?? "")"), placeholderImage: UIImage(named: "Cooking.png"))
        }
    }
}