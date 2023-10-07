//
//  UIViewControllerExtension.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 3/10/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayAlert (title: String, message: String) {
        let closeActionButton = UIAlertAction(title: "Close", style: .cancel)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(closeActionButton)
        self.present(alertController, animated: true)
    }
    
    func writeToUserDefaults <T> (key: String, value: T) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(value, forKey: key)
        userDefaults.synchronize()
    }
    
    func readFromUserDefaults <T> (key: String, defaultValue: T) -> T? {
        let userDefaults = UserDefaults.standard
        if defaultValue is String {
            if let value = userDefaults.string(forKey: key) as? String {
                return value as! T
            } else {
                return defaultValue
            }
        }
        return nil
    }
}
