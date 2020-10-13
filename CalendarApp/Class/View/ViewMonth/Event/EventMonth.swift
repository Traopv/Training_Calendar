//
//  EventMonth.swift
//  CalendarApp
//
//  Created by Apple on 10/9/20.
//

import UIKit

class EventMonth: UIView {

    @IBOutlet weak var myTable: UITableView!
    var arrEventDetail : Data!
    {
        didSet{
            myTable.reloadData()
        }
    }
    
    func fromNib(nibName : String, index : Int! = 0) -> UIView {
        let bundle = Bundle.main
        let nib = UINib(nibName: nibName, bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil)[index] as! UIView
        
        return nibView
    }
    
    //MARK:-
    //MARK: conFig
    func conFig(){
        myTable.register(UINib.init(nibName: "EventCell1", bundle: nil), forCellReuseIdentifier: "EventCell1")
        myTable.register(UINib.init(nibName: "EventCell2", bundle: nil), forCellReuseIdentifier: "EventCell2")
        myTable.register(UINib.init(nibName: "EventCell3", bundle: nil), forCellReuseIdentifier: "EventCell3")
    }
}

//MARK:-
extension EventMonth : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell1", for: indexPath) as! EventCell1
                cell.conFig()
                if arrEventDetail != nil {
                    let item = arrEventDetail
                    cell.lbTime.text = "\(item!.startDate.toString(dateFormat: "dd-MM-yyyy HH:mm")) - \(item!.endDate.toString(dateFormat: "HH:mm"))"
                    cell.lbTitle.text = item?.title
                }
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell2", for: indexPath) as! EventCell2
                cell.numberPers = 4
                cell.conFig()
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell3", for: indexPath) as! EventCell3
                cell.numberDocs = 7
                cell.conFig()
                return cell
            default:
                break
        }
        return UITableViewCell.init()
    }
}
