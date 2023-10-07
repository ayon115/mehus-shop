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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let borderColor = UIColor(named: "theme200") ?? UIColor.systemCyan
        self.logoImageView.applyCorner(cornerRadius: 15.0, borderWidth: 1.0, borderColor: borderColor)
        
        self.title = "Login"
        
        if let email = self.keychain.get("email") {
            self.usernameField.text = email
        }
        
        if let password = self.keychain.get("password") {
            self.passwordField.text = password
        }
        
    }
    
    @IBAction func onClickLoginButton () {
        
        if self.validateLoginInfo() {
            let email = self.usernameField.text!
            let password = self.passwordField.text!
            self.login(email: email, password: password)
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
    
    func login (email: String, password: String) {
        
        let url = RestClient.baseUrl + RestClient.loginUrl
        let loginRequest = LoginRequest(email: email, password: password)
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        AF.request(url, method: .post, parameters: loginRequest, encoder: JSONParameterEncoder.default, headers: headers, interceptor: nil, requestModifier: nil).responseDecodable(of: LoginResponse.self) { response in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            switch (response.result) {
                case .success:
                print(response)
                if let responseData = response.value {
                    if let accessToken = responseData.access_token {
                        self.writeToUserDefaults(key: "accessToken", value: accessToken)
                        
                        self.keychain.set(email, forKey: "email")
                        self.keychain.set(password, forKey: "password")
                        
                        self.navigate()
                    } else if let statusCode = responseData.statusCode, let message = responseData.message {
                        self.displayAlert(title: "Login failed", message: message)
                    }
                }
                case let .failure(error):
                    print(error)
            }
        }
        
        
    }
    
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
