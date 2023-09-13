//
//  ProfileController.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 6/9/23.
//

import UIKit
import ActionKit

class ProfileController: UIViewController {

    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var notifySwitch: UISwitch!
    @IBOutlet weak var notifyLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
   // @IBOutlet weak var clickmeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "My Profile"
        
        self.profilePhotoImageView.applyCorner(cornerRadius: self.profilePhotoImageView.frame.size.width/2.0, borderWidth: 1.0, borderColor: .cyan)
        self.profilePhotoImageView.image = UIImage(named: "avatar")?.withRenderingMode(.alwaysOriginal)
        // self.profilePhotoImageView.tintColor = UIColor.blue
        
        self.notifySwitch.addControlEvent(.valueChanged) {
            print("switch --> \(self.notifySwitch.isOn)")
            if self.notifySwitch.isOn {
                self.notifyLabel.text = "Notify Me When Order Processed."
            } else {
                self.notifyLabel.text = "Don't Notify Me When Order Processed."
            }
        }
        
        let singleTapGestureRecognizer = UITapGestureRecognizer() {
            self.view.backgroundColor = self.getRandomColor()
        }
        self.notifyLabel.isUserInteractionEnabled = true
        self.notifyLabel.addGestureRecognizer(singleTapGestureRecognizer)
        
      //  self.clickmeButton.setTitle("My Button", for: .normal)
      //  self.clickmeButton.addTarget(self, action: #selector(self.buttonClickHandler), for: .touchUpInside)
      //  self.clickmeButton.addControlEvent(.touchUpInside) {
      //      print("button click with ActionKit closure")
      //  }
        
        self.nameLabel.text = "Deamon Targariyen"
        self.bioLabel.text = "Prince Daemon Targaryen is a prince of the Targaryen dynasty, and the younger brother of King Viserys I Targaryen. He is the uncle of Queen Rhaenyra Targaryen, and later becomes her second husband and king consort."
        
    }
    
   
    func getRandomColor () -> UIColor {
        return UIColor(red: randomNumber(), green: randomNumber(), blue: randomNumber(), alpha: 1.0)
    }
    
    func randomNumber () -> Double {
        // get a number within 0.0 to 255.0
        return Double(arc4random() % 255) / 255.0
    }
    
    /*
    
    @IBAction func onClickMeButtonClicked () {
        print("Click me button was clicked")
    }
    
    @objc func buttonClickHandler () {
        print("my button was clicked")
    }
     */
}