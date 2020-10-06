//
//  DayCell.swift
//  CalendarApp
//
//  Created by Apple on 10/5/20.
//

import UIKit

class DayCell: UICollectionViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbHour: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbDay.layer.cornerRadius = lbDay.bounds.height / 2
        lbDay.layer.masksToBounds = true
    }
}
