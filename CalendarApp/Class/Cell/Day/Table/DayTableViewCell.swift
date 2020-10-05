//
//  DayTableViewCell.swift
//  CalendarApp
//
//  Created by Apple on 10/5/20.
//

import UIKit

class DayTableViewCell: UITableViewCell {

    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var lbHour: UILabel!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //MARK:
    //MARK: conFig
    func conFig(){
        
    }
}
