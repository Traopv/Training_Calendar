//
//  Struct.swift
//  Demo
//
//  Created by Apple on 9/23/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import Foundation

// MARK: - Datum
struct Data {
    let startDate : Date
    let endDate : Date
    let title : String
    init(startDate: Date,endDate: Date,title : String) {
        self.startDate = startDate
        self.endDate = endDate
        self.title = title
    }
}
struct EventDay: Codable {
    let date: Date
    let event: [Event]
    
    init(date: Date,event: [Event]) {
        self.date = date
        self.event = event
    }
}

// MARK: - Event
struct Event: Codable {
    let title : String
    init(title : String) {
        self.title = title
    }
}
