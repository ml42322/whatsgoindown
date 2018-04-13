//
//  MapViewController.swift
//  
//
//  Created by Michell Li on 4/10/18.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mkMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 1
        //mkMapView.showsCompass = true
        //mkMapView.showsScale = true
        //let location = CLLocationCoordinate2D(latitude: 30.2849,longitude: 97.7341)
        let initialLocation = CLLocation(latitude: 30.286272, longitude:  -97.736593)
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius, regionRadius)
            mkMapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)

        
        // 2
        /*
        let span = MKCoordinateSpanMake(0.07, 0.07)
        let region = MKCoordinateRegion(center: location, span: span)
        mkMapView.setRegion(region, animated: true)
        let scale = MKScaleView(mapView: mkMapView)
        scale.scaleVisibility = .visible // always visible
        view.addSubview(scale)
        
        //3
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "The University of Texas at Austin"
        //annotation.subtitle = "London"
        mkMapView.addAnnotation(annotation)
 */
  
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

}
