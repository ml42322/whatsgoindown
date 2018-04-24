//
//  ChooseEventLocationViewController.swift
//  whatsgoindown
//
//  Created by Wilshire Liu on 4/20/18.
//  Copyright © 2018 Wilshire Liu. All rights reserved.
//

import UIKit
import GoogleMaps

class ChooseEventLocationViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    var mapView = GMSMapView()
    var CL = CLLocationCoordinate2D()
    var address = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        mapView = GMSMapView.map(withFrame: CGRect(x: 100, y: 100, width: 400, height: 500), camera: GMSCameraPosition.camera(withLatitude: 30.2862184, longitude: -97.739388, zoom: 15.0))
        mapView.delegate = self
        
        mapView.center = self.view.center
        self.view.addSubview(mapView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        print("tap to CreateEventPage")
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate){
            response, error in guard let geoaddress = response?.firstResult()
                else{
                    return
            }
            self.address = (geoaddress.lines?.joined(separator: "\n"))!
            self.CL = coordinate
            self.performSegue(withIdentifier: "toCreateEventPage", sender: self)
        }
 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? CreateEventViewController {
            destinationVC.coordinates = CL
            destinationVC.eventAddress = address
            // Set the delegate (self = this object).
            destinationVC.delegate = self
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}
