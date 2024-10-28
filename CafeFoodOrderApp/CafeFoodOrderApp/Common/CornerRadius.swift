//
//  CornerRadius.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//

import Foundation
import UIKit


extension UIView {
    
    // Function to set corner radius for any UIView
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true // Ensures subviews are clipped to the rounded corners
    }
    
}
