//
//  ChooseEventLocationViewController.swift
//  whatsgoindown
//
//  Created by Wilshire Liu on 4/20/18.
//  Copyright © 2018 Wilshire Liu. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ChooseEventLocationViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, GMSAutocompleteResultsViewControllerDelegate {

    // Search Bar
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    //Google Map
    private let locationManager = CLLocationManager()
    var mapView = GMSMapView()
    var CL = CLLocationCoordinate2D()
    var address = String()
    var marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Manual Storyboard implementation of search bar
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let subView = UIView(frame: CGRect(x: 0, y: 65.0, width: 350.0, height: 45.0))
        
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        //Google Map
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        mapView = GMSMapView.map(withFrame: CGRect(x: 100, y: 100, width: 400, height: 400), camera: GMSCameraPosition.camera(withLatitude: 30.2862184, longitude: -97.739388, zoom: 15.0))
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
        //turn coordinates into address
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
    //CoreLocation - Getting User's current location
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
    //Search the User's input
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        address = place.formattedAddress!
 
        //turn address into coordinate
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address){(placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
            else{
                return
            }
            self.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 35, bearing: 0, viewingAngle: 0)
            self.marker.position = location.coordinate
            self.marker.title = place.name
            self.marker.map = self.mapView
        }
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
