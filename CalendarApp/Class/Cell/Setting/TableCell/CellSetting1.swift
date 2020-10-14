//
//  CellSetting1.swift
//  CalendarApp
//
//  Created by ELSAGA-MACOS on 10/14/20.
//

import UIKit

class CellSetting1: UITableViewCell {

    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbJob: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        imgCell.layer.cornerRadius = imgCell.bounds.height / 2
        imgCell.layer.masksToBounds = true
    }
    
}
