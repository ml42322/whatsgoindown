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

class CreateEventViewController: UIViewController {

    @IBOutlet weak var eventNameText: UITextField!
    @IBOutlet weak var eventAddressText: UITextField!
    @IBOutlet weak var eventTimeText: UITextField!
    @IBOutlet weak var eventTimeZoneText: UITextField!
    @IBOutlet weak var eventTypeText: UITextField!
    @IBOutlet weak var eventDescriptionText: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        if let user = user {
            let email = user.email
            lblMessage.text = "Signed in as \(email!.description)"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCreateEvent(_ sender: Any) {
        let user = Auth.auth().currentUser
        if let user = user {
            let email = user.email
            let event = Event(id: "", eventName: eventNameText.text!, eventHost: email!.description, eventAddress: eventAddressText.text!, eventTime: eventTimeText.text!, eventTimeZone: eventTimeZoneText.text!, eventType: eventTypeText.text!, eventDescription: eventDescriptionText.text!, eventLongitude: "TBD", eventLatitude: "TBD")
            DataStore.shared.addEvent(event: event)
        }
        print("Event Added")
        lblMessage.text = "Event Added!"
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
