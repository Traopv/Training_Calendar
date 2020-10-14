//
//  SettingViewController.swift
//  CalendarApp
//
//  Created by ELSAGA-MACOS on 10/14/20.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var viewContent: UIView!
    
    var arrIcon = ["setting1.png","setting2.png","setting3.png"]
    var arrTitle = ["Lịch","Thông báo","Bảo mật"]
    var views : [UIView] = [UIView]()
    
    var profileView = ProfileView().fromNib(nibName: "ProfileView") as! ProfileView
    var setCalendarView = SetCalendarView().fromNib(nibName: "SetCalendarView") as! SetCalendarView
    var setNotifiView = SetNotifiView().fromNib(nibName: "SetNotifiView") as! SetNotifiView
    var setSecurityView = SetSecurityView().fromNib(nibName: "SetSecurityView") as! SetSecurityView
    
    override func viewDidLoad() {
        super.viewDidLoad()
      conFig()
    }
    
    //MARK:-
    //MARK: config
    func conFig() {
        myTable.register(UINib.init(nibName: "CellSetting1", bundle: nil), forCellReuseIdentifier: "CellSetting1")
        myTable.register(UINib.init(nibName: "CellSetting2", bundle: nil), forCellReuseIdentifier: "CellSetting2")
        myTable.register(UINib.init(nibName: "CellSetting3", bundle: nil), forCellReuseIdentifier: "CellSetting3")
        myTable.register(UINib.init(nibName: "CellSetting4", bundle: nil), forCellReuseIdentifier: "CellSetting4")
        
        profileView.frame = CGRect(x: 0, y: 0, width: viewContent.bounds.width, height: viewContent.bounds.height)
        profileView.conFig()
        views.append(profileView)
        
        setCalendarView.frame = CGRect(x: 0, y: 0, width: viewContent.bounds.width, height: viewContent.bounds.height)
        setCalendarView.conFig()
        views.append(setCalendarView)
        
        setNotifiView.frame = CGRect(x: 0, y: 0, width: viewContent.bounds.width, height: viewContent.bounds.height)
        setNotifiView.conFig()
        views.append(setNotifiView)
        
        setSecurityView.frame = CGRect(x: 0, y: 0, width: viewContent.bounds.width, height: viewContent.bounds.height)
        setSecurityView.conFig()
        views.append(setSecurityView)
        
            for view in views {
                viewContent.addSubview(view)
            }
        viewContent.bringSubviewToFront(views[0])
        
    }
}

//MARK:-
extension SettingViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 74
        case 1:
            return 29
        case 2,3,4:
            return 70
        case 5:
            return 36
        case 6:
            return 60
        default:
            break
        }
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellSetting1", for: indexPath) as! CellSetting1
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellSetting2", for: indexPath) as! CellSetting2
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellSetting3", for: indexPath) as! CellSetting3
                let image = UIImage.init(named: arrIcon[0])
                cell.imgCell?.image = image
                cell.lbTitle.text = arrTitle[0]
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellSetting3", for: indexPath) as! CellSetting3
                let image = UIImage.init(named: arrIcon[1])
                cell.imgCell?.image = image
                cell.lbTitle.text = arrTitle[1]
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellSetting3", for: indexPath) as! CellSetting3
                let image = UIImage.init(named: arrIcon[2])
                cell.imgCell?.image = image
                cell.lbTitle.text = arrTitle[2]
                cell.viewCell.isHidden = true
                return cell
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellSetting2", for: indexPath) as! CellSetting2
                return cell
            case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellSetting4", for: indexPath) as! CellSetting4
                return cell
            default:
                break
            }
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            viewContent.bringSubviewToFront(views[0])
        case 1,5:
            print("==>")
        case 2:
            viewContent.bringSubviewToFront(views[1])
        case 3:
            viewContent.bringSubviewToFront(views[2])
        case 4:
            viewContent.bringSubviewToFront(views[3])
        case 6:
            print("==> Đăng xuất!")
        default:
            break
        }
    }
}
