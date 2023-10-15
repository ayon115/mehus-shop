//
//  AddressController.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 14/10/23.
//

import UIKit
import MapKit
import ActionKit

protocol AddressUpdateDelegate {
    func onNewAddressAdded ()
}


class AddressController: UIViewController {

    @IBOutlet weak var mkMapView: MKMapView!
    @IBOutlet weak var mTableView: UITableView!
    let defualtLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.33079800, -122.03072881);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My Address"
        
        let addAddressButton = UIBarButtonItem(title: "Add Address", actionClosure: { action in
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: Constants.addAddressController) as? AddAddressController {
                controller.addressUpdateDelegate = self
                self.navigationController?.pushViewController(controller, animated: true)
            }
        })
        self.navigationItem.rightBarButtonItem = addAddressButton
        
        self.mTableView.register(UINib(nibName: AddressCell.cellId, bundle: nil), forCellReuseIdentifier: AddressCell.cellId)
        
        self.mTableView.dataSource = self
        self.mTableView.delegate = self
        
        self.mkMapView.delegate = self
        self.mkMapView.showsUserLocation = false
        self.centerMapToLocation(location: self.defualtLocation)
        
        
        self.loadPlaces()
    }
    
    func centerMapToLocation (location: CLLocationCoordinate2D) {
         let region = MKCoordinateRegion(center: location, latitudinalMeters: 30000, longitudinalMeters: 30000)
         self.mkMapView.setRegion(region, animated: true)
     }
    
    func loadPlaces () {
        var places: [Place] = []
        for address in AppData.addresses {
            let place = Place(coordinate: address.location!, title: address.tag!)
            places.append(place)
        }
        
        self.mkMapView.addAnnotations(places)
    }
}

extension AddressController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let address = AppData.addresses[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.cellId) as! AddressCell
        cell.tagLabel.text = address.tag
        
        var addressText: String = ""
        if let a1 = address.addressLine1 {
            addressText = addressText.appending(a1)
        }
        if let a2 = address.addressLine2 {
            addressText = addressText.appending(", " + a2)
        }
        
        if let a3 = address.addressLine3 {
            addressText = addressText.appending(", " + a3)
        }
        
        cell.addressLabel.text = addressText
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

extension AddressController: AddressUpdateDelegate {
    func onNewAddressAdded() {
        self.mTableView.reloadData()
        self.loadPlaces()
    }
}

extension AddressController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("regionDidChangeAnimated")
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("mapViewDidFinishLoadingMap")
    }
        
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("didUpdate userLocation")
    }
        
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        print("didFailToLocateUserWithError")
    }
        
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let place = annotation as? Place else {
            return nil
        }
        
        print(place)
        
        var annotationView: MKAnnotationView?
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: "place") as? MKMarkerAnnotationView {
            annotationView = view
            annotationView?.annotation = annotation
        } else {
            annotationView = MKMarkerAnnotationView(annotation: place, reuseIdentifier: "place")
        }
        annotationView?.canShowCallout = true
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        return annotationView
    }
        
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let place = view.annotation as? Place
        self.displayAlert(title: "Callout Tapped", message: "You are at " + (place?.title ?? ""))
    }
    
}

class Place: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    
        super.init()
    }
    
}


