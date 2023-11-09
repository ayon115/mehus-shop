//
//  LoginController.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 22/8/23.
//

import UIKit
import Alamofire
import MBProgressHUD
import KeychainSwift

class LoginController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let keychain = KeychainSwift()
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginViewModel.loginVCDelegate = self
        self.logoImageView.applyCorner(cornerRadius: 15.0, borderWidth: 1.0, borderColor: self.loginViewModel.borderColor)
        self.title = self.loginViewModel.screenTitle
        
        self.usernameField.text = self.loginViewModel.savedEmail
        self.passwordField.text = self.loginViewModel.savedPassword
    }
    
    @IBAction func onClickLoginButton () {
        
        if self.validateLoginInfo() {
            let email = self.usernameField.text!
            let password = self.passwordField.text!
            self.loginViewModel.login(email: email, password: password)
        }
    }
    
    func validateLoginInfo () -> Bool {
        guard let email = self.usernameField.text, email.isValidEmail() else {
            self.displayAlert(title: "Email is invalid", message: "Please enter a valid email.")
            return false
        }
        
        guard let password = self.passwordField.text, password.isValidPassword() else {
            self.displayAlert(title: "Password too short", message: "Password must be at least 6 character long.")
            return false
        }
        return true
    }
    
    // UserDefaults ~ SharedPreference
    // Secure Storage Keychain ~ Google Password Manager
    // Database - sqlite, coredata

    
    func navigate () {
        if let currentWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            // sceneDelegate
            if let sceneDelegate = currentWindowScene.delegate as? SceneDelegate, let window = sceneDelegate.window {
                // print(window.rootViewController)
                
                if let tabController = self.storyboard?.instantiateViewController(withIdentifier: Constants.tabController) as? UITabBarController {
                    window.rootViewController = tabController
                }
            }
        }
    }
    
    @IBAction func onClickSignUpButton () {
        if let signupController = self.storyboard?.instantiateViewController(withIdentifier: Constants.signupController) as? SignupController {
            signupController.value = 1
            self.navigationController?.pushViewController(signupController, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let signupController = segue.destination as? SignupController {
            signupController.value = 2
        }
    }
}

extension LoginController : LoginProtocol {
    
    func onProcessStart() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func onSuccess(loginResponse: LoginResponse?) {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.navigate()
    }
    
    func onError(errorMessage: String?) {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.displayAlert(title: "Login failed", message: errorMessage ?? "")
    }
}
