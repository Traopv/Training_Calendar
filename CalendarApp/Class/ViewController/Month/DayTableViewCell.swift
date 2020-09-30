//
//  DayTableViewCell.swift
//  CalendarApp
//
//  Created by Apple on 9/30/20.
//

import UIKit

class DayTableViewCell: UITableViewCell {

    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var lbHour: UILabel!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    var arrEvent: [Event] = [Event]()
    override func awakeFromNib() {
        super.awakeFromNib()    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //MARK:-
    //MARK: ConFig
    func conFig(){
        lbDay.layer.cornerRadius = 5
        lbDay.layer.masksToBounds = true
        lbHour.layer.cornerRadius = 5
        lbHour.layer.masksToBounds = true
    }
}
