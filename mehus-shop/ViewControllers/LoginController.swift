//
//  LoginController.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 22/8/23.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let borderColor = UIColor(named: "theme200") ?? UIColor.systemCyan
        self.logoImageView.applyCorner(cornerRadius: 15.0, borderWidth: 1.0, borderColor: borderColor)
        
        self.title = "Login"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onClickLoginButton () {
        self.login()
        
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
    
    func login () {
        
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
