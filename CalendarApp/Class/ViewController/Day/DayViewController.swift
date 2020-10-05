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

    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var lbShowMonth: UILabel!
    @IBOutlet weak var btnCurrentDay: UIButton!
    @IBOutlet weak var imgCalendar: UIImageView!
    
    @IBOutlet weak var viewCollection: UIView!
    let calendarVC = CalendarVC.init()
    var allDaysInMonth: [Date] = []
    var arrEvent : [Data] = [Data]()
    var allData : [ Data] = [Data]()
    var selectedDate : Date = Date()
    {
        didSet{
            fetchDayData(date: selectedDate)
        }
    }
    var currentPage: Date {
        let offsetX = myCollection.contentOffset.x
        let index = Int(offsetX/myCollection.bounds.width)
        return listMonth[index]
    }
    let dateFormatter = DateFormatter()
    
    var listMonth: [Date] = [Date().addMonths(numberOfMonths: 3),
                             Date(),
                             Date().addMonths(numberOfMonths: 1),
                             Date().addMonths(numberOfMonths: 2),
                             Date().addMonths(numberOfMonths: 3),
                             Date()]
    
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
        calendarVC.indexType = 0
        myTable.register(UINib.init(nibName: "DayTableViewCell", bundle: nil), forCellReuseIdentifier: "DayTableViewCell")
        imgCalendar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
//        conFig(date: date)
        dateFormatter.dateFormat = "dd-MM-yyy HH:mm:ss"
        fetchAllData()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleCalendarPermissionAccessed), name: Notification.Name("CalendarAuthorized"), object: nil)
        
    }
    
    //MARK:-
    //MARK: funtion setup
    func conFig(date : Date){
        btnCurrentDay.layer.cornerRadius = 10
        btnCurrentDay.layer.masksToBounds = true
        
        self.arrEvent = GetData.findEvent1(value: date, in: self.allData) ?? []
        if self.arrEvent.count != 0 {
            self.imgCalendar.isHidden = true
            self.myTable.isHidden = false
        } else {
            self.imgCalendar.isHidden = false
            self.myTable.isHidden = true
        }
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
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        
            if self.arrEvent.count != 0 {
              self.imgCalendar.isHidden = true
              self.myTable.isHidden = false
          } else {
              self.imgCalendar.isHidden = false
              self.myTable.isHidden = true
          }
          self.myTable.reloadData()
        
    }
    
    func reloadMonthTitle() {
        lbShowMonth.text = "Tháng \(currentPage.month) - \(currentPage.year)"
    }
    
    //MARK:-
    //MARK: Button function
    
    @IBAction func btnCurrentDay(_ sender: Any) {
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
}

