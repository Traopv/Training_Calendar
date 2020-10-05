//
//  GetData.swift
//  Demo
//
//  Created by ELSAGA-MACOS on 9/15/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit
class GetData: NSObject {
    static func getDataInCalendar() -> [Data]{
        let data = EventKit.fetchEventsFromCalendar()
        var arr : [Data] = [Data]()
        let event = Data.self
        for item in data {
            arr.append(event.init(startDate: item.startDate, endDate: item.endDate, title: item.title))
        }
        return arr
    }
    
    static func findEvent1(value searchValue: Date, in array: [Data]) -> [Data]?
    {
        let day = searchValue.day
        let month = searchValue.month
        let year = searchValue.year
       
        let filter = array.filter { (item: Data) -> Bool in
            return item.startDate.day == day && item.startDate.month == month && item.startDate.year == year
        }
        
        return filter
    }
    
//    static func loadJson1() -> [EventDay]? {
//        if let path = Bundle.main.path(forResource: "Event", ofType: "json")
//        {
//             do {
//                     let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                     let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//                     if let result = jsonResult as? NSDictionary  {
//                        if let datas = result.object(forKey: "data") as? NSArray
//                        {
//                            let dateFormatter = DateFormatter()
//                            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
//                            var arrs = [EventDay]()
//
//                            for item in datas {
//                                if let item = item as? NSDictionary{
//                                    if let strDate = item.object(forKey: "date"), let events = item.object(forKey: "event") as? NSArray
//                                    {
//                                        var arrEvent = [Event]()
//                                        let date = dateFormatter.date(from: strDate as! String)!
//                                        for item1 in events {
//
//                                            if let hour = (item1 as AnyObject).object(forKey: "hours") as? String, let activiti = (item1 as AnyObject).object(forKey: "activiti") as? String {
//                                                let event = Event(hours: hour, activiti: activiti)
//                                                arrEvent.append(event)
//                                            }
//                                        }
//                                        arrs.append(EventDay(date:date, event: arrEvent))
//                                    }
//                                }
//                            }
//
//                            return arrs
//                        }
//                    }
//                 } catch {
//                      // handle error
//                 }
//        }
//        return nil
//    }
}
