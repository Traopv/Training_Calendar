//
//  HomeVC.swift
//  CalendarApp
//
//  Created by Apple on 10/15/20.
//

import UIKit

class HomeVC: UIViewController {
    // viewcontent1
    @IBOutlet weak var myCollection: UICollectionView!
    
    // viewcontent2
    @IBOutlet weak var viewContent2: UIView!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbWeather: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lbTemperature: UILabel!
    @IBOutlet weak var lbWeekDay: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbLunarDate: UILabel!
    @IBOutlet weak var lbTypeDay: UILabel!
    @IBOutlet weak var lbTypeMonth: UILabel!
    
    // viewcontent3
    @IBOutlet weak var viewContent3: UIView!
    @IBOutlet weak var myTable: UITableView!
    
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conFig()
    }
    //MARK:-
    //MARK: conFig
    func conFig(){
        myTable.register(UINib.init(nibName: "HomeTbCell1", bundle: nil), forCellReuseIdentifier: "HomeTbCell1")
        myCollection.register(UINib.init(nibName: "HomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
        
        viewContent2.layer.cornerRadius = 12
        viewContent2.layer.masksToBounds = true
        viewContent3.layer.cornerRadius = 12
        viewContent3.layer.masksToBounds = true
    }
}

//MARK:-
extension HomeVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 2 * 100
        } else {
            return 2 * 90
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTbCell1", for: indexPath) as! HomeTbCell1
        cell.conFig()
        cell.imgCell?.image = UIImage.init(named: "iconTBHome2.png")
        cell.lbDay.text = "Thứ 5 - 15/10/2020"
        
        if indexPath.row == 0 {
            let date = Date()
            cell.imgCell?.image = UIImage.init(named: "iconTbHome")
            cell.lbDay.text = "Hôm nay - \(date.toString(dateFormat: "dd/MM/yyyy"))"
            cell.typeTable = true
        }
        return cell
    }
}

//MARK:-
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionCell
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        return cell
    }
}

//MARK:-
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = myCollection.bounds.width
        let height: CGFloat = myCollection.bounds.height
        let numberOfItemInRow : CGFloat = 2
        let numberOfRow : CGFloat = 2
        let iLineSpaing : CGFloat = 12
        let interItemSpacing : CGFloat = 12
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
        return 12
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
