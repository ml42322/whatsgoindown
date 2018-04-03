//
//  CreateEventViewController.swift
//  whatsgoindown
//
//  Created by Wilshire Liu on 4/2/18.
//  Copyright © 2018 Wilshire Liu. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {

    @IBOutlet weak var eventNameText: UITextField!
    @IBOutlet weak var eventHostText: UITextField!
    @IBOutlet weak var eventAddressText: UITextField!
    @IBOutlet weak var eventTimeText: UITextField!
    @IBOutlet weak var eventTypeText: UITextField!
    @IBOutlet weak var eventDescriptionText: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCreateEvent(_ sender: Any) {
        print("Button pressed")
        let event = Event(id: "", eventName: eventNameText.text!, eventHost: eventHostText.text!, eventAddress: eventAddressText.text!, eventTime: eventTimeText.text!, eventType: eventTypeText.text!, eventDescription: eventDescriptionText.text!)
        DataStore.shared.addEvent(event: event)
        lblMessage.text = "Event Added!"
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
