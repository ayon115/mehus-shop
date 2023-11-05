//
//  OrdersController.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 2/9/23.
//

import UIKit

class OrdersController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "My Orders"
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(profileUpdated(notification:)), name: Notification.Name(AppData.broadcastName), object: nil)
    }
    
    @objc func profileUpdated (notification: NSNotification) {
        print("\(AppData.broadcastName) notification received.")
        if let updatedName = notification.object as? String {
            print("\(AppData.broadcastName) notification received at \(Constants.ordersController) with Data = \(updatedName)")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
