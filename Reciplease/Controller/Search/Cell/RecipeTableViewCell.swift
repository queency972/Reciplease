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
final class RecipeTableViewCell: UITableViewCell {

    // MARK: - Outlets
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
            guard let recipeTime = recipe?.totalTime else {return}
            guard let yield = recipe?.yield else {return}
            if recipeTime < seconde {
                preparationTimeLabel.text = "\(String(describing: recipeTime))s"
            }
            else {
                preparationTimeLabel.text = "\(recipeTime.timeInSecondsToString)m"
            }
            recipeImage.sd_setImage(with: URL(string: "\(recipe?.image ?? "")"), placeholderImage: UIImage(named: "Cooking.png"))
            yieldLabel.text = "\(String(describing: yield)) yield(s)"
        }
    }

    var recipeEntity: RecipeEntity? {
        didSet {
            titleLabel.text = recipeEntity?.title
            guard let recipeTime = recipeEntity?.time else {return}
            preparationTimeLabel.text = "\(String(describing: recipeTime))s"
            //guard let recipeImage = recipeEntity?.image?.data else {return}
            recipeImage.image = UIImage(data: (recipeEntity?.image?.data)!)
            guard let recipeYield = recipeEntity?.yield else {return}
            yieldLabel.text = "\(String(describing: recipeYield)) yield(s)"
        }
    }
}
