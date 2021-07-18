//
//  CustomTextField.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 17/10/20.
//

import Foundation
import UIKit
@IBDesignable
class CustomTextField: UITextField {
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = borderRadius
        }
    }
}

