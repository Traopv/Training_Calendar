//
//  EventKit.swift
//  CalendarApp
//
//  Created by Apple on 9/29/20.
//

import UIKit
import EventKit

class EventKit {
    
    static func fetchEventsFromCalendar() -> [EKEvent] {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        var arr : [EKEvent] = [EKEvent]()
        switch (status) {
            case .notDetermined:
                requestAccessToCalendar()
            case .authorized:
                arr = self.fetchEventsFromCalendar(calendarTitle: "Calendar")
                break
            case .restricted, .denied: break

            }
        return arr
    }

    static func requestAccessToCalendar() {
        let eventStore = EKEventStore()
            eventStore.requestAccess(to: EKEntityType.event) { (accessGranted, error) in
            self.fetchEventsFromCalendar(calendarTitle: "Calendar")
        }
    }

    // MARK: Fetech Events from Calendar
    static func fetchEventsFromCalendar(calendarTitle: String) -> [EKEvent] {
        let eventStore = EKEventStore()
        let calendars = eventStore.calendars(for: .event)
        var addedEvents : [EKEvent] = [EKEvent]()
        //PGAEventsCalendar
        for calendar:EKCalendar in calendars {
            if calendar.title == calendarTitle {
                let selectedCalendar = calendar
                let startDate = NSDate(timeIntervalSinceNow: -60*60*24*180)
                let endDate = NSDate(timeIntervalSinceNow: 60*60*24*180)
                let predicate = eventStore.predicateForEvents(withStart: startDate as Date, end: endDate as Date, calendars: [selectedCalendar])
                addedEvents = eventStore.events(matching: predicate) as [EKEvent]
            }
        }
        return addedEvents
    }
}
