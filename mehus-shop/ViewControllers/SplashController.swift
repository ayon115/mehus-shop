//
//  ViewController.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 22/8/23.
//

import UIKit

class SplashController: UIViewController {
    
    @IBOutlet var label: UILabel!
    var timer: Timer?
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(makeTransition), userInfo: nil, repeats: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
        super.viewDidDisappear(animated)
    }
    
    
    @objc func makeTransition () {
        print("timer ended")
        self.timer?.invalidate()
    
        if let currentWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            // sceneDelegate
            if let sceneDelegate = currentWindowScene.delegate as? SceneDelegate, let window = sceneDelegate.window {
                // print(window.rootViewController)
                
                if let authViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.authNavigationController) as? UINavigationController {
                    window.rootViewController = authViewController
                }
            }
        }
    
    }

}

