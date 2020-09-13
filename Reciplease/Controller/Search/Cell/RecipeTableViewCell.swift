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
    @IBOutlet weak var yieldLabel: UILabel!

    // MARK: - Properties

    // Set interface
    var recipe: Recipe? {
        didSet {
            let seconde: Int = 60
            titleLabel.text = recipe?.label
            if recipe!.totalTime < seconde {
                preparationTimeLabel.text = "\(String(describing: recipe!.totalTime))s"
            }
            else {
                preparationTimeLabel.text = "\(recipe!.totalTime.timeInSecondsToString)m"
            }
            recipeImage.sd_setImage(with: URL(string: "\(recipe?.image ?? "")"), placeholderImage: UIImage(named: "Cooking.png"))
            yieldLabel.text = "\(String(describing: recipe!.yield)) yield(s)"
        }
    }

    var recipeEntity: RecipeEntity? {
        didSet {
            titleLabel.text = recipeEntity?.title
            preparationTimeLabel.text = "\(String(describing: recipeEntity!.time!))s"
            recipeImage.image = UIImage(data: (recipeEntity?.image?.data)!)
            yieldLabel.text = "\(String(describing: recipeEntity!.yield!)) yield(s)"
        }
    }
}
