//
//  GetData.swift
//  Demo
//
//  Created by ELSAGA-MACOS on 9/15/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit
class GetData: NSObject {
    
    static func findEvent1(value searchValue: Date, in array: [EventDay]) -> [Event]?
    {
        let day = searchValue.day
        let month = searchValue.month
        let year = searchValue.year
       
        let filter = array.filter { (item: EventDay) -> Bool in
            return item.date.day == day && item.date.month == month && item.date.year == year
        }
        
        return filter.first?.event
    }
    
    static func loadJson1() -> [EventDay]? {
        if let path = Bundle.main.path(forResource: "Event", ofType: "json")
        {
             do {
                     let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                     let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                     if let result = jsonResult as? NSDictionary  {
                        if let datas = result.object(forKey: "data") as? NSArray
                        {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                            var arrs = [EventDay]()
                
                            for item in datas {
                                if let item = item as? NSDictionary{
                                    if let strDate = item.object(forKey: "date"), let events = item.object(forKey: "event") as? NSArray
                                    {
                                        var arrEvent = [Event]()
                                        let date = dateFormatter.date(from: strDate as! String)!
                                        for item1 in events {
                                            
                                            if let hour = (item1 as AnyObject).object(forKey: "hours") as? String, let activiti = (item1 as AnyObject).object(forKey: "activiti") as? String {
                                                let event = Event(hours: hour, activiti: activiti)
                                                arrEvent.append(event)
                                            }
                                        }
                                        arrs.append(EventDay(date:date, event: arrEvent))
                                    }
                                }
                            }
                            
                            return arrs
                        }
                    }
                 } catch {
                      // handle error
                 }
        }
        return nil
    }
}
