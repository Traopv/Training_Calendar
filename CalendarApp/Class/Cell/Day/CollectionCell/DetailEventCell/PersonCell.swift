//
//  PersonCell.swift
//  CalendarApp
//
//  Created by Apple on 10/8/20.
//

import UIKit

class PersonCell: UICollectionViewCell {

    @IBOutlet weak var viewConten: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var lbNumberPers: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK:-
    //MARK: ConFig
    func conFig(){
        viewConten.layer.cornerRadius = 10
        viewConten.layer.masksToBounds = true

        img1.layer.cornerRadius = img1.bounds.height / 2
        img1.layer.masksToBounds = true
        img1.layer.borderWidth = 1
        img1.layer.borderColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        img2.layer.cornerRadius = img2.bounds.height / 2
        img2.layer.masksToBounds = true
        img2.layer.borderWidth = 1
        img2.layer.borderColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        img3.layer.cornerRadius = img3.bounds.height / 2
        img3.layer.masksToBounds = true
        img3.layer.borderWidth = 1
        img3.layer.borderColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        view4.layer.cornerRadius = view4.bounds.height / 2
        view4.layer.masksToBounds = true
        view4.layer.borderWidth = 1
        view4.layer.borderColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
