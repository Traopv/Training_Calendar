//
//  CalendarViewController.swift
//  Demo
//
//  Created by ELSAGA-MACOS on 9/9/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit
import EventKit;

class DayViewController: UIViewController {
    
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var myTableEvent: UITableView!
    @IBOutlet weak var lbShowMonth: UILabel!
    @IBOutlet weak var btnCurrentDay: UIButton!
    @IBOutlet weak var imgCalendar: UIImageView!
    @IBOutlet weak var imgEventDetail: UIImageView!
    @IBOutlet weak var viewCollection: UIView!
    
    let calendarVC = CalendarVC.init()
    var allDaysInMonth: [Date] = []
    var arrEvent : [Data] = [Data]()
    var allData : [ Data] = [Data]()
    var arrDoc : [Int] = [Int]()
    var arrEventDetail : Data!
    {
        didSet{
            myTableEvent.reloadData()
        }
    }
    var selectedDate : Date = Date()
    {
        didSet{
            fetchDayData(date: selectedDate)
            if arrEvent.count != 0 {
                arrEventDetail = arrEvent[0]
                myTable.reloadData()
            }
        }
    }
    
    var currentIndex: Int = 1
    var currentYear : Int = 0
    var currentMonth : Int = 0
    var currentDay : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let calendar = Calendar.current
        currentMonth = calendar.component(.month, from: Date())
        currentYear = calendar.component(.year, from: Date())
        currentDay = calendar.component(.day, from: Date())
        
        calendarVC.view.frame = CGRect(x: 0, y: 0, width: viewCollection.bounds.width, height: viewCollection.bounds.height)
        viewCollection.addSubview(calendarVC.view)
        viewCollection.bringSubviewToFront(calendarVC.view)
        
        calendarVC.closureChooseDate = { (dateChoose: Date) in
            self.selectedDate = dateChoose
        }
        calendarVC.indexType = 0
        myTable.register(UINib.init(nibName: "DayTableViewCell", bundle: nil), forCellReuseIdentifier: "DayTableViewCell")
        myTableEvent.register(UINib.init(nibName: "EventCell1", bundle: nil), forCellReuseIdentifier: "EventCell1")
        myTableEvent.register(UINib.init(nibName: "EventCell2", bundle: nil), forCellReuseIdentifier: "EventCell2")
        myTableEvent.register(UINib.init(nibName: "EventCell3", bundle: nil), forCellReuseIdentifier: "EventCell3")
        imgCalendar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        fetchAllData()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleCalendarPermissionAccessed), name: Notification.Name("CalendarAuthorized"), object: nil)
        conFig()
        if arrEvent.count != 0 {
            arrEventDetail = arrEvent[0]
        }
    }
    
    //MARK:-
    //MARK: funtion setup
    func conFig(){
    }
    
    //show Detail Event
    func showDetailEvent(){
        
    }
    
    //load data
    @objc  func handleCalendarPermissionAccessed(){
        DispatchQueue.main.async {
            self.fetchAllData()
        }
    }
    func fetchAllData()
    {
        if(EventKit.checkCalendarPermission()){
            allData = GetData.getDataInCalendar()
            fetchDayData(date: selectedDate)
        }
    }
    func fetchDayData(date: Date){
        arrEvent = GetData.findEvent1(value: date, in: self.allData) ?? []
        if self.arrEvent.count != 0 {
            self.imgCalendar.isHidden = true
            self.imgEventDetail.isHidden = true
            self.myTable.isHidden = false
            self.myTableEvent.isHidden = false
            arrEventDetail = arrEvent[0]
        } else {
            self.imgCalendar.isHidden = false
            self.imgEventDetail.isHidden = false
            self.myTable.isHidden = true
            self.myTableEvent.isHidden = true
        }
        self.myTable.reloadData()
        conFig()
    }
    
    //MARK:-
    //MARK: Button function
    @IBAction func btnCurrentDay(_ sender: Any) {
    }
}

//MARK:-
extension DayViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countArr = 0
        if tableView == self.myTable {
            countArr = arrEvent.count
        }
        if tableView == self.myTableEvent {
            countArr =  3
        }
        return countArr
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.myTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayTableViewCell", for: indexPath) as! DayTableViewCell
            let item = arrEvent[indexPath.row]
            cell.lbDay.text = item.startDate.toString(dateFormat: "dd/MM")
            cell.lbHour.text = item.startDate.toString(dateFormat: "HH:mm")
            cell.lbTitle.text = item.title
            cell.conFig()
            return cell
       } else if tableView == self.myTableEvent {
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
                    cell.numberDocs = 3
                    cell.conFig()
                    return cell
                default:
                    break
            }
            return UITableViewCell.init()
       }
       return UITableViewCell.init()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.myTable {
            if arrEvent.count != 0 {
                arrEventDetail = arrEvent[indexPath.row]
                myTableEvent.reloadData()
            }
        }
    }
}
