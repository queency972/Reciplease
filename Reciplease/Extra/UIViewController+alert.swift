//
//  UIViewController+alert.swift
//  Reciplease
//
//  Created by Steve Bernard on 05/06/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

// MARK: - Extension UIViewController
extension UIViewController {
    // Method to show alerts when an error occur
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
