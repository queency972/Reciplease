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

    override func awakeFromNib() {
        super.awakeFromNib()
        gradientImage()
    }

    // MARK: - Properties

    // Set interface from network
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
     // Set interface from Coredata
    var recipeEntity: RecipeEntity? {
        didSet {
            titleLabel.text = recipeEntity?.title
            guard let recipeTime = recipeEntity?.time else {return}
            preparationTimeLabel.text = "\(String(describing: recipeTime))s"
            guard let recipesImage = recipeEntity?.image else {return}
            recipeImage.image = UIImage(data: (recipesImage))
            guard let recipeYield = recipeEntity?.yield else {return}
            yieldLabel.text = "\(String(describing: recipeYield)) yield(s)"
        }
    }

    func gradientImage() {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 55, width: frame.width.advanced(by: 25), height: frame.height.advanced(by: 0))
        gradient.colors = [UIColor.white.cgColor.alpha, UIColor.black.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.1)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.9)
        recipeImage.layer.insertSublayer(gradient, at: 0)
    }
}
