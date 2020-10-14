//
//  ProfileView.swift
//  CalendarApp
//
//  Created by ELSAGA-MACOS on 10/14/20.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbEdit: UIButton!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var btnEditPass: UIButton!
    @IBOutlet weak var viewEdit: UIView!
    
    var arrTitle = ["Họ và tên","Phòng ban","Chức danh","SĐT cơ quan","SĐT di động","Email"]
    var isUserInteractive : Bool = false
    {
        didSet{
            myTable.reloadData()
        }
    }
    
    func fromNib(nibName : String, index : Int! = 0) -> UIView {
        let bundle = Bundle.main
        let nib = UINib(nibName: nibName, bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil)[index] as! UIView
        
        return nibView
    }
    
    //MARK:-
    //MARK: config
    func conFig() {
        imgProfile.layer.cornerRadius = imgProfile.bounds.height / 2
        imgProfile.layer.masksToBounds = true
        myTable.layer.cornerRadius = 15
        myTable.layer.masksToBounds = true
        viewEdit.layer.cornerRadius = 15
        viewEdit.layer.masksToBounds = true
        myTable.register(UINib.init(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
    }
    
    //MARK:-
    //MARK: button function
    @IBAction func editProfile(_ sender: Any) {
        isUserInteractive = !isUserInteractive
    }
    @IBAction func editPassword(_ sender: Any) {
    }
}

//MARK:-
extension ProfileView : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.lbTitle.text = arrTitle[indexPath.row]
        cell.txtName.isUserInteractionEnabled = isUserInteractive
        if indexPath.row == 5 {
            cell.viewCell.isHidden = true
        }
        return cell
    }
}
