//
//  CreateEventViewController.swift
//  whatsgoindown
//
//  Created by Wilshire Liu on 4/2/18.
//  Copyright © 2018 Wilshire Liu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleMaps

class CreateEventViewController: UIViewController {

    @IBOutlet weak var eventNameText: UITextField!
    @IBOutlet weak var eventAddressText: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var eventTypeText: UITextField!
    @IBOutlet weak var eventDescriptionText: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    
    var startDate: String?
    var endDate: String?
    var coordinates = CLLocationCoordinate2D()
    var delegate: ChooseEventLocationViewController?
    
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
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let string = dateFormatter.string(from: date.date)
        return string
    }
    
    @IBAction func btnCreateEvent(_ sender: Any) {
        let user = Auth.auth().currentUser
        if let user = user {
            let email = user.email
            
            startDate = handleDatePicker(date: startDatePicker)
            endDate = handleDatePicker(date: endDatePicker)
            
            let event = Event(id: "", eventName: eventNameText.text!, eventHost: email!.description, eventAddress: eventAddressText.text!, eventStartDate: startDate!, eventEndDate: endDate!, eventType: eventTypeText.text!, eventDescription: eventDescriptionText.text!, eventLongitude: coordinates.longitude.description, eventLatitude: coordinates.latitude.description)
            DataStore.shared.addEvent(event: event)
        }
        print("Event Added")
        lblMessage.text = "Event added!"
        self.performSegue(withIdentifier: "postCreateEvent", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        if let user = user {
            let email = user.email
            lblMessage.text = "Signed in as \(email!.description)"
        }
        let currentDate = NSDate()
        self.startDatePicker.minimumDate = currentDate as Date
        self.endDatePicker.minimumDate = currentDate as Date
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
