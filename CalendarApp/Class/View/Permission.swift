//
//  Permission.swift
//  CalendarApp
//
//  Created by Apple on 10/5/20.
//

import UIKit

class Permission: UIView {
    
    func fromNib(nibName : String, index : Int! = 0) -> UIView {
        let bundle = Bundle.main
        let nib = UINib(nibName: nibName, bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil)[index] as! UIView
        
        return nibView
    }
    
    @IBAction func clickButton(_ sender: Any) {
        EventKit.checkCalendarPermission()
    }
}
