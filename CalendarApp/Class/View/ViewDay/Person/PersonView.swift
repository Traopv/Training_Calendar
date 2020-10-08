//
//  PersonView.swift
//  CalendarApp
//
//  Created by ELSAGA-MACOS on 10/7/20.
//

import UIKit

class PersonView: UIView {

     func fromNib(nibName : String, index : Int! = 0) -> UIView {
           let bundle = Bundle.main
           let nib = UINib(nibName: nibName, bundle: bundle)
           let nibView = nib.instantiate(withOwner: self, options: nil)[index] as! UIView
           return nibView
       }
}
