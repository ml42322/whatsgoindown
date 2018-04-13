//
//  Event.swift
//  whatsgoindown
//
//  Created by Wilshire Liu on 4/2/18.
//  Copyright © 2018 Wilshire Liu. All rights reserved.
//

import Foundation

class Event {
    
    var id: String
    var eventName: String
    var eventHost: String
    var eventAddress: String
    var eventStartDate: String
    var eventEndDate: String
    var eventType: String
    var eventDescription: String
    var eventLongitude: String
    var eventLatitude: String
    
    init(id: String, eventName: String, eventHost: String, eventAddress: String, eventStartDate: String, eventEndDate: String, eventType: String, eventDescription: String, eventLongitude: String, eventLatitude: String) {
        self.id = id
        self.eventName = eventName
        self.eventHost = eventHost
        self.eventAddress = eventAddress
        self.eventStartDate = eventStartDate
        self.eventEndDate = eventEndDate
        self.eventType = eventType
        self.eventDescription = eventDescription
        self.eventLongitude = eventLongitude
        self.eventLatitude = eventLatitude
    }
}
