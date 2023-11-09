//
//  LoginViewModel.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 7/11/23.
//

import Foundation
import UIKit
import KeychainSwift

class LoginViewModel {
    
    var keychain = KeychainSwift()
    var loginService = LoginService()
    
    var loginVCDelegate: LoginProtocol?
    
    var screenTitle: String {
        return "Login"
    }
    
    var borderColor: UIColor {
        return UIColor(named: "theme200") ?? UIColor.systemCyan
    }
    
    var savedEmail: String {
        if let email = self.keychain.get("email") {
            return email
        } else {
            return ""
        }
    }
    
    var savedPassword: String {
        if let password = self.keychain.get("password") {
            return password
        } else {
            return ""
        }
    }
    
    func login (email: String, password: String) {
        self.loginService.initiateLogin(email: email, password: password, loginDelegate: self)
    }
    
}

extension LoginViewModel: LoginProtocol {
    
    func onProcessStart() {
        
    }
    
    func onSuccess(loginResponse: LoginResponse?) {
        
        if let accessToken = loginResponse?.access_token {
           // self.writeToUserDefaults(key: "accessToken", value: accessToken)
           // self.keychain.set(email, forKey: "email")
           // self.keychain.set(password, forKey: "password")
           // self.navigate()
            print(accessToken)
            self.loginVCDelegate?.onSuccess(loginResponse: loginResponse)
        }
        
    }
    
    func onError(errorMessage: String?) {
       // 
        print(errorMessage)
        self.loginVCDelegate?.onError(errorMessage: errorMessage)
    }
}
