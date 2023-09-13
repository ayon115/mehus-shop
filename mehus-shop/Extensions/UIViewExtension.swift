//
//  UIViewExtension.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 29/8/23.
//

import Foundation
import UIKit

extension UIView {
    
    public func applyCorner (cornerRadius: Double, borderWidth: Double, borderColor: UIColor) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
