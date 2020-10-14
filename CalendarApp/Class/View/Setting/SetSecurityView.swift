//
//  SetSecurityView.swift
//  CalendarApp
//
//  Created by ELSAGA-MACOS on 10/14/20.
//

import UIKit

class SetSecurityView: UIView {

    @IBOutlet weak var viewCell: UIView!
    
    func fromNib(nibName : String, index : Int! = 0) -> UIView {
           let bundle = Bundle.main
           let nib = UINib(nibName: nibName, bundle: bundle)
           let nibView = nib.instantiate(withOwner: self, options: nil)[index] as! UIView
           
           return nibView
       }
           
   //MARK:-
   //MARK: config
   func conFig() {
       viewCell.layer.cornerRadius = 15
       viewCell.layer.masksToBounds = true
   }
    
    //MARK:-
    //MARK: button function
    @IBAction func chooseSecurity(_ sender: UISwitch) {
        if(sender.isOn == true){
            print("==> true")
        } else {
            print("==> false")
        }
    }
}
