//
//  StringExtension.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 3/10/23.
//

import Foundation

extension String {
    
    func isValidEmail () -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword () -> Bool {
        return self.count > 5
    }
    
}
