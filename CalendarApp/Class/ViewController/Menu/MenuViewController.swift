//
//  MenuViewController.swift
//  CalendarApp
//
//  Created by Apple on 10/13/20.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var viewContent: UIView!
    
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    let arrIconMenu = ["home.png","calendar.png","growth.png","noti.png","ic_message.png","group.png","settings 2.png"]
    
    var views : [UIView] = [UIView]()
    var homeVC = HomeViewController.init()
    var notifiVC = NotifiViewController.init()
    var reportVC = ReportViewController.init()
    var appVC = AppViewController.init()
    var settingVC = SettingViewController.init()
    var home = HomeVC.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conFig()
        setUpMenu()
        reportVC.closurePushView = {
            let listReportVC = ListReportViewController.init(nibName: "ListReportViewController", bundle: nil)
            self.navigationController?.pushViewController(listReportVC, animated: true)
        }
    }
    
    //MARK:-
    //MARK: config
    func conFig() {
        self.navigationController?.isNavigationBarHidden = true
        myCollection.register(UINib.init(nibName: "CellMenu", bundle: nil), forCellWithReuseIdentifier: "CellMenu")
    }
    
    func setUpMenu(){
        homeVC.view.frame = CGRect(x: 0, y: 0, width: viewContent.bounds.width, height: viewContent.bounds.height)
        notifiVC.view.frame = CGRect(x: 0, y: 0, width: viewContent.bounds.width, height: viewContent.bounds.height)
        reportVC.view.frame = CGRect(x: 0, y: 0, width: viewContent.bounds.width, height: viewContent.bounds.height)
        appVC.view.frame = CGRect(x: 0, y: 0, width: viewContent.bounds.width, height: viewContent.bounds.height)
        settingVC.view.frame = CGRect(x: 0, y: 0, width: viewContent.bounds.width, height: viewContent.bounds.height)
        home.view.frame = CGRect(x: 0, y: 0, width: viewContent.bounds.width, height: viewContent.bounds.height)
        views.append(home.view)
        views.append(homeVC.view)
        views.append(notifiVC.view)
        views.append(reportVC.view)
        views.append(appVC.view)
        views.append(settingVC.view)
            for view in views {
                viewContent.addSubview(view)
            }
        viewContent.bringSubviewToFront(views[0])
    }
}

//MARK:-
extension MenuViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrIconMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMenu", for: indexPath) as! CellMenu
        let imageName = UIImage(named: arrIconMenu[indexPath.row])
        cell.iconMenu?.image = imageName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewContent.bringSubviewToFront(views[indexPath.row])
    }
}

//MARK:-
extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = myCollection.bounds.width
        let height: CGFloat = myCollection.bounds.height
        let numberOfItemInRow : CGFloat = 1
        let numberOfRow : CGFloat = 7
        let iLineSpaing : CGFloat = 30
        let interItemSpacing : CGFloat = 0
        let iWidth = (width - (numberOfItemInRow - 1) * interItemSpacing) / numberOfItemInRow
        let iHeight = (height - (numberOfRow - 1) * iLineSpaing) / numberOfRow
        
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: iWidth, height: iHeight)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = iLineSpaing
        collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
        print("==> item size",CGSize(width: iWidth, height: iHeight))
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
        return 30
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

