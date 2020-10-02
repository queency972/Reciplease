//
//  DisplayRecipeAlert.swift
//  Reciplease
//
//  Created by Steve Bernard on 13/09/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

// MARK: - Extension UITableView

// Set a message when tableView is empty
extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Noteworthy", size: 18)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
