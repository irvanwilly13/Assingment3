//
//  FormView.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//

import UIKit

extension UIView {
    
    // Function to create a form-like view with standard padding, border, and corner radius
    func setFormStyle(borderWidth: CGFloat = 1.0, borderColor: UIColor = .lightGray, cornerRadius: CGFloat = 8.0, padding: CGFloat = 16.0) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        
        // Add padding for content
        if let stackView = self as? UIStackView {
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        } else {
            let paddingView = UIView()
            paddingView.frame = self.bounds.insetBy(dx: padding, dy: padding)
            self.addSubview(paddingView)
        }
    }
    
    // Function to apply shadow to form view
    func setFormShadow(shadowColor: UIColor = .black, shadowOffset: CGSize = CGSize(width: 0, height: 2), shadowOpacity: Float = 0.2, shadowRadius: CGFloat = 4.0) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
    }
    
    // Function to create padding inside a form field (e.g., UITextField)
    func setFieldPadding(left: CGFloat, right: CGFloat) {
        if let textField = self as? UITextField {
            let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: left, height: textField.frame.height))
            textField.leftView = paddingViewLeft
            textField.leftViewMode = .always
            
            let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: right, height: textField.frame.height))
            textField.rightView = paddingViewRight
            textField.rightViewMode = .always
        }
    }
}
