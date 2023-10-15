//
//  AddAddressController.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 14/10/23.
//

import UIKit
import CoreLocation

class AddAddressController: UIViewController {

    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var address2Field: UITextField!
    @IBOutlet weak var address3Field: UITextField!
    @IBOutlet weak var tagField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    let locationManager: CLLocationManager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    let defualtLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(23.7649, 90.3899);
    
    var addressUpdateDelegate: AddressUpdateDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add New Address"
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationButton.addControlEvent(.touchUpInside) {
            self.streetField.text = ""
            self.address2Field.text = ""
            self.address3Field.text = ""
            self.locationManager.requestLocation()
        }
        
        self.saveButton.addControlEvent(.touchUpInside) {
            guard let a1 = self.streetField.text else {
                return
            }
            guard let a2 = self.address2Field.text else {
                return
            }
            guard let a3 = self.address3Field.text else {
                return
            }
            guard let tag = self.tagField.text else {
                return
            }
            
            let address = Address()
            address.addressLine1 = a1
            address.addressLine2 = a2
            address.addressLine3 = a3
            address.tag = tag
            address.location = self.lastKnownLocation
            AppData.addresses.append(address)
            self.addressUpdateDelegate.onNewAddressAdded()
            self.navigationController?.popViewController(animated: true)
        }

    }
    
    func extractAddressFromLocation (location: CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { places, error in
            if let places = places, let place = places.last {
                
                print(place)
                
                if let a1 = place.name {
                    self.streetField.text = a1
                }
                
                if let a2 = place.locality {
                    self.address2Field.text = a2
                }
                
                if let postcode = place.postalCode, let area = place.administrativeArea, let country = place.country {
                    self.address3Field.text = String("\(postcode), \(area), \(country)")
                }
                
                if let location = place.location {
                    self.lastKnownLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                }
            }
        }
    }

}

extension AddAddressController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        if locations.count > 0, let last = locations.last {
            self.extractAddressFromLocation(location: last)
        }
    }
    
}
