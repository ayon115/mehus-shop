//
//  CreateProductControllerViewController.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 7/10/23.
//

import UIKit
import ActionKit
import Alamofire
import MBProgressHUD

class CreateProductController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var pickImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Create A Product"
        self.pickImageButton.addControlEvent(.touchUpInside) {
            self.showImagePickerDialog()
        }
    }
    

    func showImagePickerDialog () {
        
        let controller = UIAlertController(title: "Select Image", message: "Select an image", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Open Camera", style: .default) { action in
            let controller = UIImagePickerController()
            controller.sourceType = .camera
            controller.delegate = self
            controller.allowsEditing = true
            self.present(controller, animated: true)
        }
    
        let pickAction = UIAlertAction(title: "Open Gallery", style: .default) { action in
            let controller = UIImagePickerController()
            controller.sourceType = .photoLibrary
            controller.delegate = self
            controller.allowsEditing = true
            self.present(controller, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        controller.addAction(cameraAction)
        controller.addAction(pickAction)
        controller.addAction(cancelAction)
        self.present(controller, animated: true)
    }

}

extension CreateProductController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       // print(info)
        picker.dismiss(animated: true)
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.productImageView.image = image
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            self.uploadImageToServer(image: image)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("User cancelled image picker")
        picker.dismiss(animated: true)
    }
    
    func uploadImageToServer (image: UIImage) {
        
        guard let imageData = image.pngData() else {
            return
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = RestClient.baseUrl + RestClient.photoUploadUrl
        let token = self.readFromUserDefaults(key: "accessToken", defaultValue: "") ?? ""
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        
        print(imageData.count)
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "file")
        }, to: url, usingThreshold: .min, method: .post, headers: headers, interceptor: nil, fileManager: FileManager.default, requestModifier: nil).responseDecodable(of: FileUploadResponse.self) { response in
            debugPrint(response)
            MBProgressHUD.hide(for: self.view, animated: true)
            switch (response.result) {
                case .success:
                    print("File uploaded")
                if let fileResponse = response.value {
                    print(fileResponse)
                }
                
                case let .failure(error):
                    print(error)
            }
        }
    }
}
