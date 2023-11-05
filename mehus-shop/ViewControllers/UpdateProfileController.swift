//
//  UpdateProfileController.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 4/11/23.
//

import UIKit

class UpdateProfileController: UIViewController {

    var updateProfileDelegate: UpdateProfileProtocol?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var broadcastButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Update My Profile"
        let editProfileButton = UIBarButtonItem(title: "Save") { action in
            print("Save button clicked.")
            self.updateProfileDelegate?.justNotify()
            self.navigationController?.popViewController(animated: true)
        }
        self.navigationItem.rightBarButtonItem = editProfileButton
        
        self.updateButton.addControlEvent(.touchUpInside) {
            
            guard let updatedName = self.nameTextField.text, updatedName.count > 2 else {
                return
            }
            
            print("Update button clicked.")
            self.updateProfileDelegate?.notifyWithObject(updatedName: updatedName)
            self.navigationController?.popViewController(animated: true)
        }
        
        self.broadcastButton.addControlEvent(.touchUpInside) {
            
            guard let updatedName = self.nameTextField.text, updatedName.count > 2 else {
                return
            }
            print("Broadcast button clicked.")
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: NSNotification.Name(AppData.broadcastName), object: updatedName)
            
        }
    }
    
}
