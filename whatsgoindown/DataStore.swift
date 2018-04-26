//
//  DataStore.swift
//  whatsgoindown
//
//  Created by Wilshire Liu on 4/2/18.
//  Copyright © 2018 Wilshire Liu. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class DataStore {
    
    // Instantiate the singleton object.
    static let shared = DataStore()
    
    private var ref: DatabaseReference!
    private var events: [Event]! = []
    
    // Making the init method private means only this class can instantiate an object of this type.
    private init() {
        // Get a database reference.
        // Needed before we can read/write to/from the firebase database.
        ref = Database.database().reference()
    }
    
    func count() -> Int {
        return events.count
    }
    
    func getEvent(index: Int) -> Event {
        return events[index]
    }
    
    func loadEvents() {
        // Start with an empty array.
        events = [Event]()
        
        // Fetch the data from Firebase and store it in our internal events array.
        // This is a one-time listener.
        self.events.removeAll()
        ref.child("events").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get the top-level dictionary.
            let value = snapshot.value as? NSDictionary
            
            if let eventList = value {
                // Iterate over the person objects and store in our internal people array.
                for e in eventList {
                    let id = e.key as! String
                    let event = e.value as! [String:String]
                    let eventName = event["eventName"]
                    let eventHost = event["eventHost"]
                    let eventAddress = event["eventAddress"]
                    let eventStartDate = event["eventStartDate"]
                    let eventEndDate = event["eventEndDate"]
                    let eventType = event["eventType"]
                    let eventDescription = event["eventDescription"]
                    let eventLongitude = event["eventLongitude"]
                    let eventLatitude = event["eventLatitude"]
                    let newEvent = Event(id: id, eventName: eventName!, eventHost: eventHost!, eventAddress: eventAddress!, eventStartDate: eventStartDate!, eventEndDate: eventEndDate!, eventType: eventType!, eventDescription: eventDescription!, eventLongitude: eventLongitude!, eventLatitude: eventLatitude!)
                    self.events.append(newEvent)
                }
                print("datastore:", self.events)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func addEvent(event: Event) {
        let key = ref.childByAutoId().key
        // define array of key/value pairs to store for this person.
        let eventRecord = [
            "id" : key,
            "eventName": event.eventName,
            "eventHost": event.eventHost,
            "eventAddress": event.eventAddress,
            "eventStartDate": event.eventStartDate,
            "eventEndDate": event.eventEndDate,
            "eventType": event.eventType,
            "eventDescription": event.eventDescription,
            "eventLongitude": event.eventLongitude,
            "eventLatitude": event.eventLatitude
        ]
        
        // Save to Firebase.
        self.ref.child("events").child(key).setValue(eventRecord)
        
        // Also save to our internal array, to stay in sync with what's in Firebase.
        events.append(event)
    }
    
    func deleteEvent(event: Event) {
        var i = 0
        while i < events.count {
            if events[i].id == event.id {
                break;
            }
            i += 1
        }
        self.ref.child("events").child(event.id).removeValue()
        events.remove(at: i)
        print("Event deleted")
    }
}
