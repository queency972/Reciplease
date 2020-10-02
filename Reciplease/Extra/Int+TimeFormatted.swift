//
//  TimeFormatted.swift
//  Reciplease
//
//  Created by Steve Bernard on 11/08/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

// MARK: - Extension Int

// Extension convert seconde to minute
extension Int {
    var timeInSecondsToString: String {
        get {
            let minutes = self % (60 * 60) / 60
            let hours = self / 60 / 60
            let timeFormatString = String(format: "%01dh%02dm", hours, minutes)
            return timeFormatString
        }
    }
}
