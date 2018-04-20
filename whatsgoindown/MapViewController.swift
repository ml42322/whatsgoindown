//
//  MapViewController.swift
//  
//
//  Created by Michell Li on 4/10/18.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    var mapView = GMSMapView()
    var eventsList = [Event]()
    var markers = [GMSMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        
        mapView = GMSMapView.map(withFrame: CGRect(x: 100, y: 100, width: 400, height: 500), camera: GMSCameraPosition.camera(withLatitude: 30.2862184, longitude: -97.739388, zoom: 15.0))
        mapView.delegate = self
        
        mapView.center = self.view.center
        self.view.addSubview(mapView)
        
        let count = DataStore.shared.count()
        var i = 0
        while i < count {
            eventsList.append(DataStore.shared.getEvent(index: i))
            markers.append(GMSMarker())
            i += 1
        }
        var j = 0
        for e in eventsList {
            markers[j].position = CLLocationCoordinate2D(latitude: Double(e.eventLatitude)!, longitude: Double(e.eventLongitude)!)
            markers[j].title = e.eventName
            markers[j].snippet = "\(e.eventType), \(e.eventDescription)"
            markers[j].map = mapView
            j += 1
        }
        print(eventsList)
        
        //mapView.isMyLocationEnabled = true
        //mapView.settings.myLocationButton = true
        if let mylocation = mapView.myLocation {
            print("User's location: \(mylocation)")
        } else {
            print("User's location is unknown")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
