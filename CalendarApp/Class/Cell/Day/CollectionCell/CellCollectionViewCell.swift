//
//  CellCollectionViewCell.swift
//  Demo
//
//  Created by ELSAGA-MACOS on 9/10/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class CellCollectionViewCell: UICollectionViewCell {

    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    @IBOutlet weak var myCollection: UICollectionView!
    var allDaysInMonth : [Date] = []
    var arrEvent : [Data] = [Data]()
    let currentDate = Date()
    var month : Int = 0
    var year : Int = 0
    var indexType = 0
    var endOfWeek = ""
    var isShowButton = false
    var closureShowEvent: ((_ date : Date) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myCollection.register(UINib.init(nibName: "CellDate", bundle: nil), forCellWithReuseIdentifier: "CellDate")
        myCollection.register(UINib.init(nibName: "DayCell", bundle: nil), forCellWithReuseIdentifier: "DayCell")
        layoutSubviews()
    }
    
    //MARK:-
    //MARK: funtion setup
    func loadData(){
        allDaysInMonth = Utils.getAllDateOfMonth(month: month, year: year)
        myCollection.reloadData()
    }
}

extension CellCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allDaysInMonth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellDate", for: indexPath) as! CellDate
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
        if indexType == 0 {
            let date = allDaysInMonth[indexPath.row] as Date
            if (currentDate.day == date.day && currentDate.month == date.month && currentDate.year == date.year){
                cell.viewCell.backgroundColor = .red
            } else {
                cell.viewCell.backgroundColor = .clear
            }
            cell.lbDay.text = date.toString(dateFormat: "dd")
            cell.date = date
            
            if (date.month == month) {
                //thang hien tai
                cell.lbDay.textColor = .white
            } else {
                //thang truoc hoac hoac thang sau
                cell.lbDay.textColor = .gray
                if date.day == 1 {
                    cell.lbDay.text = "01/\(date.month)"
                }
            }
            // show su kien
            let item = GetData.findEvent1(value: date, in: arrEvent)
            if item?.count != 0 {
                cell.imgCell.isHidden = false
            } else {
                cell.imgCell.isHidden = true
            }
            return cell
        } else {
            let date = allDaysInMonth[indexPath.row] as Date
            let currentDate = Date()
            if (currentDate.day == date.day && currentDate.month == date.month && currentDate.year == date.year){
                cell1.lbDay.backgroundColor = .red
            } else {
                cell1.lbDay.backgroundColor = .clear
            }
            cell1.lbDay.text = date.toString(dateFormat: "dd")
            
            if (date.month == month) {
                //thang hien tai
                cell1.lbDay.textColor = .white
            } else {
                //thang truoc hoac hoac thang sau
                cell1.lbDay.textColor = .gray
                if date.day == 1 {
                    cell1.lbDay.text = "01/\(date.month)"
                }
            }
            // show su kien
            let items = GetData.findEvent1(value: date, in: arrEvent)
            if items?.count != 0 {
                cell1.imgCell.isHidden = false
                cell1.lbTitle.isHidden = false
                cell1.lbHour.isHidden = false
                
            } else {
                cell1.imgCell.isHidden = true
                cell1.lbTitle.isHidden = true
                cell1.lbHour.isHidden = true
            }
            let filter = items?.filter { (item: Data) -> Bool in
                return item.startDate.day == date.day && item.startDate.month == date.month && item.startDate.year == date.year
            }
            filter?.forEach{item in
                cell1.lbHour.text = item.startDate.toString(dateFormat: "HH:mm")
                cell1.lbTitle.text = item.title
            }
            return cell1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexType == 1 {
            let date = allDaysInMonth[indexPath.row] as Date
            let  detailMonth : DetailMonth = DetailMonth().fromNib(nibName: "DetailMonth", index: 0) as! DetailMonth
            detailMonth.currentDate = date
            detailMonth.arrEvent = GetData.findEvent1(value: date, in: arrEvent) ?? []
            detailMonth.conFig()
            let klc = KLCPopup.init(contentView: detailMonth)
            klc?.showType = .bounceInFromLeft
            klc?.dismissType = .bounceOutToTop
            klc?.maskType = .dimmed
            klc?.shouldDismissOnBackgroundTouch = true
            klc?.show()
        } else {
            let date = allDaysInMonth[indexPath.row] as Date
            closureShowEvent?(date)
        }
    }
}

//MARK:-
extension CellCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = myCollection.bounds.width
        let height: CGFloat = myCollection.bounds.height
        let numberOfItemInRow : CGFloat = 7
        let numberOfRow : CGFloat = 6
        let iLineSpaing : CGFloat = 1
        let interItemSpacing : CGFloat = 0.5
        let iWidth = (width - (numberOfItemInRow - 1) * interItemSpacing) / numberOfItemInRow
        let iHeight = (height - (numberOfRow - 1) * iLineSpaing) / numberOfRow
        
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: iWidth, height: iHeight)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = iLineSpaing
        collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
        return CGSize(width: iWidth, height: iHeight)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
