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
    
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var myTableDoc: UITableView!
    @IBOutlet weak var lbShowMonth: UILabel!
    @IBOutlet weak var btnCurrentDay: UIButton!
    @IBOutlet weak var imgCalendar: UIImageView!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbCheck: UILabel!
    @IBOutlet weak var lbUseEquipment: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var viewEvent2: UIView!
    @IBOutlet weak var viewEvent3: UIView!
    @IBOutlet weak var viewEvent: UIView!
    // Danh sach nguoi tham gia
    @IBOutlet weak var viewPer1: UIView!
    @IBOutlet weak var viewPer2: UIView!
    @IBOutlet weak var viewPer3: UIView!
    let viewPers1 = PerssionView.init()
    let viewPers2 = PerssionView.init()
    let viewPers3 = PerssionView.init()
    
    @IBOutlet weak var viewCollection: UIView!
    let calendarVC = CalendarVC.init()
    var allDaysInMonth: [Date] = []
    var arrEvent : [Data] = [Data]()
    var allData : [ Data] = [Data]()
    var arrDoc : [Int] = [Int]()
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
        
        calendarVC.closureChooseDate = { (dateChoose: Date) in
            self.selectedDate = dateChoose
        }
        calendarVC.indexType = 0
        myTable.register(UINib.init(nibName: "DayTableViewCell", bundle: nil), forCellReuseIdentifier: "DayTableViewCell")
        myTableDoc.register(UINib.init(nibName: "DocumentCell", bundle: nil), forCellReuseIdentifier: "DocumentCell")
        imgCalendar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        dateFormatter.dateFormat = "dd-MM-yyy HH:mm:ss"
        fetchAllData()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleCalendarPermissionAccessed), name: Notification.Name("CalendarAuthorized"), object: nil)
        addViewPerssion(viewPer1,viewPers: viewPers1)
        addViewPerssion(viewPer2,viewPers: viewPers2)
        addViewPerssion(viewPer3,viewPers: viewPers3)
        conFig()
    }
    
    //MARK:-
    //MARK: funtion setup
    func conFig(){
        lbCheck.layer.cornerRadius = 15
        lbCheck.layer.masksToBounds = true
        if arrEvent.count != 0 {
            let item = arrEvent[0]
            lbTime.text  = "\(item.startDate.toString(dateFormat: "dd-MM-yyyy HH:mm")) - \(item.endDate.toString(dateFormat: "HH:mm"))"
            lbTitle.text = item.title
            viewEvent2.hide(byHeight: true)
            viewEvent3.hide(byHeight: true)
        } else {
            //viewEvent.isHidden = true
        }
        for i in 1...3 {
            arrDoc.append(i)
        }
    }
    
    //add view
    func addViewPerssion(_ view : UIView, viewPers: UIViewController){
        viewPers.view.frame = CGRect(x: 0, y: 0, width: 212, height: 79)
        view.addSubview(viewPers.view)
        view.bringSubviewToFront(viewPers.view)
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
            self.myTable.isHidden = false
        } else {
            self.imgCalendar.isHidden = false
            self.myTable.isHidden = true
        }
        self.myTable.reloadData()
        //viewEvent.isHidden = false
        conFig()
        
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
        //return arrEvent.count
        var countArr = 0
        if tableView == self.myTable {
            countArr = arrEvent.count
        }
        if tableView == self.myTableDoc {
            countArr =  arrDoc.count
        }
        return countArr
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if tableView == self.myTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayTableViewCell", for: indexPath) as! DayTableViewCell
            let item = arrEvent[indexPath.row]
            cell.lbDay.text = item.startDate.toString(dateFormat: "dd/MM")
            cell.lbHour.text = item.startDate.toString(dateFormat: "HH:mm")
            cell.lbTitle.text = item.title
            cell.conFig()
            return cell
       } else { //if tableView == self.myTableDoc {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath) as! DocumentCell
           return cell
       }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrEvent.count != 0 {
            //viewEvent.isHidden = false
            let item = arrEvent[indexPath.row]
            lbTime.text  = "\(item.startDate.toString(dateFormat: "dd-MM-yyyy HH:mm")) - \(item.endDate.toString(dateFormat: "HH:mm"))"
            lbTitle.text = item.title
            viewEvent2.hide(byHeight: true)
            viewEvent3.hide(byHeight: true)
        }
    }
}
