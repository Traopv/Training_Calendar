//
//  HomeTbCell1.swift
//  CalendarApp
//
//  Created by Apple on 10/15/20.
//

import UIKit

class HomeTbCell1: UITableViewCell {

    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var myTable: UITableView!
    
    var typeTable = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:-
    //MARK: conFig
    func conFig(){
        myTable.register(UINib.init(nibName: "HomeCell1", bundle: nil), forCellReuseIdentifier: "HomeCell1")
        myTable.register(UINib.init(nibName: "HomeCell2", bundle: nil), forCellReuseIdentifier: "HomeCell2")
    }
}

//MARK:-
extension HomeTbCell1: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if typeTable {
            return 72
        } else {
            return 63
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if typeTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell1", for: indexPath) as! HomeCell1
            cell.viewCell.backgroundColor = #colorLiteral(red: 0.3345046639, green: 0.5131199956, blue: 0.7133221626, alpha: 1)
            cell.viewCell.layer.cornerRadius = 10
            cell.viewCell.layer.masksToBounds = true
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell2", for: indexPath) as! HomeCell2
            cell.viewCell.backgroundColor = #colorLiteral(red: 0.2813538909, green: 0.3842124343, blue: 0.4815735221, alpha: 1)
            cell.viewCell.layer.cornerRadius = 10
            cell.viewCell.layer.masksToBounds = true
            return cell
        }
        return UITableViewCell.init()
    }
}
