//
//  ProfileEventDetailViewController.swift
//  whatsgoindown
//
//  Created by Wilshire Liu on 4/26/18.
//  Copyright © 2018 Wilshire Liu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GooglePlaces

class ProfileEventDetailViewController: UIViewController, GMSAutocompleteResultsViewControllerDelegate {
    
    //Create database Reference to Read and Write Data
    var ref: DatabaseReference!
    
    var event: Event!
    var delegate: Any?
    var alertController:UIAlertController? = nil
    
    // Search Bar
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    
    //Text Fields
    @IBOutlet weak var txtDescr: UITextField!
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var txtName: UITextField!
    
    var startDate: String?
    var endDate: String?
    var coordinates = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        //Manual Storyboard implementation of search bar
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let subView = UIView(frame: CGRect(x: 5, y: 155, width: 75, height: 30.0))
        searchController?.searchBar.searchBarStyle = .minimal
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        //format the dates
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        let startDate = dateFormatter.date(from: (event?.eventStartDate)!)
        let endDate = dateFormatter.date(from: (event?.eventEndDate)!)
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short

        
        txtName.text = event?.eventName
        txtType.text = event?.eventType
        txtDescr.text = event?.eventDescription
        startDatePicker.date = startDate!
        endDatePicker.date = endDate!
        searchController?.searchBar.text = event?.eventAddress
    }
    
    //Date Picker
    @IBAction func startDateAction(_ sender: Any) {
        let string = handleDatePicker(date: startDatePicker)
        print(string)
    }
    
    @IBAction func endDateAction(_ sender: Any) {
        let string = handleDatePicker(date: endDatePicker)
        print(string)
    }
    
    func handleDatePicker(date: UIDatePicker) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        let string = dateFormatter.string(from: date.date)
        return string
    }
    
    //Back, Update, Delete Buttons
    @IBAction func backBtn(_ sender: Any) {
        if ((delegate as? ProfileViewController) != nil){
            self.performSegue(withIdentifier: "backToProfile", sender: self)
        }
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        let user = Auth.auth().currentUser
        if let user = user {
            //initializing database ref
            ref = Database.database().reference()
            
            //Update dates
            startDate = handleDatePicker(date: startDatePicker)
            endDate = handleDatePicker(date: endDatePicker)
            self.ref.child("events/\(event.id)/eventEndDate").setValue(endDate)
            event.eventEndDate = endDate!
            
            self.ref.child("events/\(event.id)/eventStartDate").setValue(startDate)
            event.eventStartDate = startDate!
            
            //Update fields only if they have changed
            if txtDescr.text != event.eventDescription{
                self.ref.child("events/\(event.id)/eventDescription").setValue(txtDescr.text)
                event.eventDescription = txtDescr.text!
            }
            
            if txtName.text != event.eventName{
                self.ref.child("events/\(event.id)/eventName").setValue(txtName.text)
                event.eventName = txtName.text!
            }
            
            if txtType.text != event.eventType{
                self.ref.child("events/\(event.id)/eventType").setValue(txtType.text)
                event.eventType = txtType.text!
            }
            
            //Handle Address Change
            if searchController?.searchBar.text != event.eventAddress{
                self.ref.child("events/\(event.id)/eventAddress").setValue(searchController?.searchBar.text)
                event.eventAddress = (searchController?.searchBar.text)!
                
                self.ref.child("events/\(event.id)/eventLatitude").setValue(coordinates.latitude.description)
                event.eventLatitude = coordinates.latitude.description
                
                self.ref.child("events/\(event.id)/eventLongitude").setValue(coordinates.longitude.description)
                event.eventLongitude = coordinates.longitude.description
            }
        /*
        let OKAction = UIAlertAction(title: "Update Event", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in
            // delete old event and make a new one
            DataStore.shared.deleteEvent(event: self.event);
            DataStore.shared.addEvent(event: self.event)

            if ((self.delegate as? ProfileViewController) != nil){
                self.performSegue(withIdentifier: "backToProfile", sender: self)
            }
        }
        self.alertController!.addAction(OKAction)
        self.present(self.alertController!, animated: true, completion:nil)
        print("Event Updated")
        self.performSegue(withIdentifier: "backToProfile", sender: self)
             */
        }
 
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        self.alertController = UIAlertController(title: "Delete Event", message: "Do you really want to delete this event?", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            print("Cancel Button Pressed");
        }
        self.alertController!.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in
            print("Delete Button Pressed");
            DataStore.shared.deleteEvent(event: self.event);
            if ((self.delegate as? ProfileViewController) != nil){
                self.performSegue(withIdentifier: "backToProfile", sender: self)
            }
        }
        self.alertController!.addAction(OKAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Search the User's input
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        searchController?.searchBar.text = place.formattedAddress!

        //turn address into coordinate
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(place.formattedAddress!){(placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else{
                    return
            }
            self.coordinates = location.coordinate
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
