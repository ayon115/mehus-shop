//
//  ProfileController.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 6/9/23.
//

import UIKit
import ActionKit
import Alamofire
import MBProgressHUD
import Kingfisher

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
        
        self.nameLabel.text = "Deamon Targariyen"
        self.bioLabel.text = "Prince Daemon Targaryen is a prince of the Targaryen dynasty, and the younger brother of King Viserys I Targaryen. He is the uncle of Queen Rhaenyra Targaryen, and later becomes her second husband and king consort."
       
        self.fetchUserProfile()
        
        let editProfileButton = UIBarButtonItem(title: "Update Profile") { action in
            print("Update profile clicked.")
            if let updateProfileController = self.storyboard?.instantiateViewController(withIdentifier: Constants.updateProfileController) as? UpdateProfileController {
                updateProfileController.updateProfileDelegate = self
                self.navigationController?.pushViewController(updateProfileController, animated: true)
            }
        }
        self.navigationItem.rightBarButtonItem = editProfileButton
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(profileUpdated(notification:)), name: Notification.Name(AppData.broadcastName), object: nil)
        
    }
    
    @objc func profileUpdated (notification: NSNotification) {
        print("\(AppData.broadcastName) notification received.")
        if let updatedName = notification.object as? String {
            print("\(AppData.broadcastName) notification received at \(Constants.profileController) with Data = \(updatedName)")
        }
    }
    
   
    func getRandomColor () -> UIColor {
        return UIColor(red: randomNumber(), green: randomNumber(), blue: randomNumber(), alpha: 1.0)
    }
    
    func randomNumber () -> Double {
        // get a number within 0.0 to 255.0
        return Double(arc4random() % 255) / 255.0
    }
    
    func fetchUserProfile () {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = RestClient.baseUrl + RestClient.profileUrl
        let token = self.readFromUserDefaults(key: "accessToken", defaultValue: "") ?? ""
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).responseDecodable(of: ProfileResponse.self) { response in
            debugPrint(response)
            MBProgressHUD.hide(for: self.view, animated: true)
            
            switch (response.result) {
                case .success:
                    print("Validation Successful")
                if let profile = response.value {
                    self.updateUI(profile: profile)
                }
                
                case let .failure(error):
                    print(error)
            }
        }
    }
    
    func updateUI (profile: ProfileResponse) {
        self.nameLabel.text = profile.name
        self.bioLabel.text = profile.role
        if let url = URL(string: profile.avatar) {
            self.profilePhotoImageView.kf.setImage(with: url)
        }
    }
}

extension ProfileController: UpdateProfileProtocol {
    
    func justNotify() {
        print("justNotify has been called from next view controller")
    }
    
    func notifyWithObject(updatedName: String) {
        print("notifyWithObject has been called from next view controller with Text => \(updatedName)")
        self.nameLabel.text = updatedName
    }
}
