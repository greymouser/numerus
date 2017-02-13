//
//  Configuration.swift
//  Numerus
//
//  Created by Armando Di Cianno on 5/16/16.
//  Copyright © 2016 Armando Di Cianno. All rights reserved.
//

import UIKit

/**
 A helper class to store global settings for use app-wide.
 */
struct Configuration {
    
    // MARK: - fonts
    
    struct Font {
        static let defaultFont = UIFont(name: "Copperplate", size: 16)
        static let titleFont   = UIFont(name: "Copperplate-Bold",  size: 16)
        static let smallFont   = UIFont(name: "Copperplate-Light", size: 12)
    }
    
    
    // MARK: - misc UI layout attributes
    
    struct UI {
        static let defaultInsets        = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        static let backgroundColor      = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.0)
        static let mainTextFieldsHeight = 120
    }
}
