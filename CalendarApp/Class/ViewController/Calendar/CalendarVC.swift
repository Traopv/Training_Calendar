//
//  CalendarVC.swift
//  CalendarApp
//
//  Created by Apple on 10/5/20.
//

import UIKit

class CalendarVC: UIViewController {

    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var lbShowMonth: UILabel!
    @IBOutlet weak var btnCurrentDay: UIButton!
    var indexType = 0
    var wieghtView = 0.0
    var heightView = 0.0
    var allDaysInMonth: [Date] = []
    var arrEvent : [Data] = [Data]()
    var allData : [ Data] = [Data]()
    let currentDate = Date()
    var selectedDate : Date = Date()
    {
        didSet{
            fetchDayData(date: selectedDate)
            //myCollection.reloadData()
        }
    }
    var closureChooseDate: ((_ date : Date) -> Void)?
    
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
        self.view.frame = CGRect(x: 0.0, y: 0.0, width: wieghtView, height: heightView)
        let calendar = Calendar.current
        currentMonth = calendar.component(.month, from: Date())
        currentYear = calendar.component(.year, from: Date())
        currentDay = calendar.component(.day, from: Date())
        
        myCollection.register(UINib.init(nibName: "CellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CellCollectionViewCell")
        lbShowMonth.text = "Tháng \(currentMonth) - \(currentYear)"
        conFig()
        self.navigationController?.isNavigationBarHidden = true
        dateFormatter.dateFormat = "dd-MM-yyy HH:mm:ss"
        fetchAllData()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleCalendarPermissionAccessed), name: Notification.Name("CalendarAuthorized"), object: nil)
        btnCurrentDay.isHidden = true
    }
    
    //MARK:-
    //MARK: funtion setup
    func conFig(){
        btnCurrentDay.layer.cornerRadius = 10
        btnCurrentDay.layer.masksToBounds = true
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
            myCollection.reloadData()
        }
    }
    func fetchDayData(date: Date){
        arrEvent = GetData.findEvent1(value: date, in: self.allData) ?? []
        
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
extension CalendarVC : UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMonth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollectionViewCell", for: indexPath) as! CellCollectionViewCell
        //cell.myCollection.reloadData()
        let date    = listMonth[indexPath.row]
        cell.month  = date.month
        cell.year   = date.year
        cell.indexType = indexType
        cell.arrEvent = allData
        cell.loadData()
        cell.closureShowEvent = { (dateChoose: Date) in
            self.closureChooseDate?(dateChoose)
            //collectionView.reloadData()
            self.btnCurrentDay.isHidden = false
            self.selectedDate = dateChoose
        }
        return cell
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("scrollViewDidEndScrollingAnimation")
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = myCollection.contentOffset.x
        if offsetX < scrollView.bounds.width {
            currentIndex = listMonth.count - 2
            print("prev index: \(currentIndex)")
            
            if offsetX == 0 {
                generatePrevDateData()
            }
            
            weak var weakSelf = self
            DispatchQueue.main.async {
                if let strongSelf = weakSelf {
                    strongSelf.myCollection.scrollToItem(at: IndexPath(row: strongSelf.currentIndex, section: 0), at: .left, animated: false)
                    strongSelf.reloadMonthTitle()
                }
            }
        } else {
            var index: Int = Int(offsetX/scrollView.bounds.width)
            index = index >= listMonth.count ? listMonth.count - 1 : index
            print("next index: \(index)")
            
            weak var weakSelf = self
            if index == listMonth.count - 1 {
                DispatchQueue.main.async {
                    if let strongSelf = weakSelf {
                        strongSelf.generateNextDateData()
                        strongSelf.currentIndex = 1
                        strongSelf.myCollection.scrollToItem(at: IndexPath(row: strongSelf.currentIndex, section: 0), at: .left, animated: false)
                        strongSelf.reloadMonthTitle()
                    }
                }
            } else {
                currentIndex = index
                reloadMonthTitle()
            }
        }
    }
    
    func generatePrevDateData() {
        let date = listMonth[1]
        
        print("generatePrevDateData month: \(date.month) - \(date.year)")
        
        let list: [Date] = [date.addMonths(numberOfMonths: -1),
                            date.addMonths(numberOfMonths: -4),
                            date.addMonths(numberOfMonths: -3),
                            date.addMonths(numberOfMonths: -2),
                            date.addMonths(numberOfMonths: -1),
                            date]

        listMonth = list
        myCollection.reloadData()
    }
    
    func generateNextDateData() {
        let date = listMonth[4]
        
        print("generateNextDateData month: \(date.month) - \(date.year)")
        
        let list: [Date] = [date.addMonths(numberOfMonths: -1),
                            date.addMonths(numberOfMonths: 1),
                            date.addMonths(numberOfMonths: 2),
                            date.addMonths(numberOfMonths: 3),
                            date.addMonths(numberOfMonths: 4),
                            date]

        listMonth = list
        myCollection.reloadData()
        
    }
}
//MARK:-
extension CalendarVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
