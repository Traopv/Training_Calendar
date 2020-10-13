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
    @IBOutlet weak var lbShowMonth: UILabel!
    @IBOutlet weak var btnCurrentDay: UIButton!
    @IBOutlet weak var imgCalendar: UIImageView!
    @IBOutlet weak var imgEventDetail: UIImageView!
    @IBOutlet weak var viewCollection: UIView!
    @IBOutlet weak var viewEventDetail: UIView!
    @IBOutlet weak var lbNotEvent: UILabel!
    
    let eventMonth = EventMonth().fromNib(nibName: "EventMonth") as! EventMonth
    let calendarVC = CalendarVC.init()
    var allDaysInMonth: [Date] = []
    var arrEvent : [Data] = [Data]()
    var allData : [ Data] = [Data]()
    var arrDoc : [Int] = [Int]()
    var selectedDate : Date = Date()
    {
        didSet{
            fetchDayData(date: selectedDate)
            if arrEvent.count != 0 {
                eventMonth.arrEventDetail = arrEvent[0]
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
//        eventMonth.frame = CGRect(x: 0, y: 0, width: 803, height: 834)
        eventMonth.frame = CGRect(x: 0, y: 0, width: viewEventDetail.bounds.width, height: viewEventDetail.bounds.height)
        eventMonth.conFig()
        viewEventDetail.addSubview(eventMonth)
        
        calendarVC.indexType = 0
        myTable.register(UINib.init(nibName: "DayTableViewCell", bundle: nil), forCellReuseIdentifier: "DayTableViewCell")
        imgCalendar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        fetchAllData()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleCalendarPermissionAccessed), name: Notification.Name("CalendarAuthorized"), object: nil)
        if arrEvent.count != 0 {
            eventMonth.arrEventDetail = arrEvent[0]
        }
    }
    
    //MARK:-
    //MARK: funtion setup
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
            self.lbNotEvent.isHidden = true
            self.myTable.isHidden = false
            self.viewEventDetail.isHidden = false
        } else {
            self.imgCalendar.isHidden = false
            self.imgEventDetail.isHidden = false
            self.lbNotEvent.isHidden = false
            self.myTable.isHidden = true
            self.viewEventDetail.isHidden = true
        }
        self.myTable.reloadData()
    }
}

//MARK:-
extension DayViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayTableViewCell", for: indexPath) as! DayTableViewCell
        let item = arrEvent[indexPath.row]
        cell.lbDay.text = item.startDate.toString(dateFormat: "dd/MM")
        cell.lbHour.text = item.startDate.toString(dateFormat: "HH:mm")
        cell.lbTitle.text = item.title
        cell.conFig()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrEvent.count != 0 {
            eventMonth.arrEventDetail = arrEvent[indexPath.row]
            eventMonth.myTable.reloadData()
        }
    }
}
