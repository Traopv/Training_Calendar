//
//  AppViewController.swift
//  CalendarApp
//
//  Created by ELSAGA-MACOS on 10/14/20.
//

import UIKit

class AppViewController: UIViewController {

    @IBOutlet weak var myCollection: UICollectionView!
    
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    var arrIcon = ["aiChat.png","netView.png","hop.png","cctv.png","file.png","qttudong.png"]
    var arrTitle = ["AIChat","Netview","Họp","CCTV","Quản lý văn bản","Quan trứ tự động",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conFig()
    }
 //MARK:-
    //MARK: config
    func conFig() {
        myCollection.register(UINib.init(nibName: "CellApp", bundle: nil), forCellWithReuseIdentifier: "CellApp")
    }
}

//MARK:-
extension AppViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellApp", for: indexPath) as! CellApp
        let imageName = UIImage(named: arrIcon[indexPath.row])
        cell.imgCell?.image = imageName
        cell.lbTitle.text = arrTitle[indexPath.row]
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.row == 2{
//            closurePushView?()
//        }
//    }
}

//MARK:-
extension AppViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = myCollection.bounds.width
        let height: CGFloat = myCollection.bounds.height
        let numberOfItemInRow : CGFloat = 5
        let numberOfRow : CGFloat = 3
        let iLineSpaing : CGFloat = 50
        let interItemSpacing : CGFloat = 50
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
        return 40
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
}

