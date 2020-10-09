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
    @IBOutlet weak var myTable: UITableView!
    
    var arrEvent : [Data] = [Data]()
    {
        didSet{
            myTable.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbDay.layer.cornerRadius = lbDay.bounds.height / 2
        lbDay.layer.masksToBounds = true
        myTable.register(UINib.init(nibName: "MonthTBCell", bundle: nil), forCellReuseIdentifier: "MonthTBCell")
    }
}

//MARK:-
extension DayCell : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEvent.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MonthTBCell", for: indexPath) as! MonthTBCell
        let item = arrEvent[indexPath.row]
        cell.lbTime.text = item.startDate.toString(dateFormat: "HH:mm")
        cell.lbTitle.text = item.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  eventMonth : EventMonth = EventMonth().fromNib(nibName: "EventMonth", index: 0) as! EventMonth
        eventMonth.conFig()
        eventMonth.layer.cornerRadius = 15
        eventMonth.layer.masksToBounds = true
        let klc = KLCPopup.init(contentView: eventMonth)
        klc?.showType = .bounceInFromLeft
        klc?.dismissType = .bounceOutToTop
        klc?.maskType = .dimmed
        klc?.shouldDismissOnBackgroundTouch = true
        klc?.show()
    }
}
