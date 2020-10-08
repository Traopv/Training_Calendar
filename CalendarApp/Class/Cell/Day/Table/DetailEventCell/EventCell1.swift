//
//  EventCell1.swift
//  CalendarApp
//
//  Created by ELSAGA-MACOS on 10/7/20.
//

import UIKit

class EventCell1: UITableViewCell {

    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbCheck: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbUseDevice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:-
    //MARK: conFig
    func conFig(){
        lbCheck.layer.cornerRadius = 15
        lbCheck.layer.masksToBounds = true
    }
    
}
