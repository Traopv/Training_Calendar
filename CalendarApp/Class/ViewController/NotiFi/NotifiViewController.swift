//
//  NotifiViewController.swift
//  CalendarApp
//
//  Created by Apple on 10/13/20.
//

import UIKit

class NotifiViewController: UIViewController {

    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var myTableDetail: UITableView!
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var btnNotifiInternal: UIButton!
    @IBOutlet weak var btnNotifiBad: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conFig()
    }
    
    //MARK:-
    //MARK: config
    func conFig() {
        myTable.register(UINib.init(nibName: "ListNotifiCell", bundle: nil), forCellReuseIdentifier: "ListNotifiCell")
        myTableDetail.register(UINib.init(nibName: "CellDetailNotifi1", bundle: nil), forCellReuseIdentifier: "CellDetailNotifi1")
        myTableDetail.register(UINib.init(nibName: "CellDetailNotifi2", bundle: nil), forCellReuseIdentifier: "CellDetailNotifi2")
        myTableDetail.register(UINib.init(nibName: "CellDetailNotifi3", bundle: nil), forCellReuseIdentifier: "CellDetailNotifi3")
        myTableDetail.register(UINib.init(nibName: "EventCell3", bundle: nil), forCellReuseIdentifier: "EventCell3")
        btnNotification.layer.cornerRadius = 20
        btnNotification.layer.masksToBounds = true
        btnNotification.backgroundColor = #colorLiteral(red: 0.2813538909, green: 0.3842124343, blue: 0.4815735221, alpha: 1)
        btnNotifiInternal.layer.cornerRadius = 20
        btnNotifiInternal.layer.masksToBounds = true
        btnNotifiInternal.backgroundColor = .clear
        btnNotifiBad.layer.cornerRadius = 20
        btnNotifiBad.layer.masksToBounds = true
        btnNotifiBad.backgroundColor = .clear
    }
    
    //MARK:-
    //MARK: button function
    @IBAction func chooseNotifi(_ sender: Any) {
        btnNotification.backgroundColor = #colorLiteral(red: 0.2813538909, green: 0.3842124343, blue: 0.4815735221, alpha: 1)
        btnNotifiBad.backgroundColor = .clear
        btnNotifiInternal.backgroundColor = .clear
    }
    @IBAction func chooseNotifiInternal(_ sender: Any) {
        btnNotifiInternal.backgroundColor = #colorLiteral(red: 0.2813538909, green: 0.3842124343, blue: 0.4815735221, alpha: 1)
        btnNotifiBad.backgroundColor = .clear
        btnNotification.backgroundColor = .clear
    }
    @IBAction func chooseNotifiBad(_ sender: Any) {
        btnNotifiBad.backgroundColor = #colorLiteral(red: 0.2813538909, green: 0.3842124343, blue: 0.4815735221, alpha: 1)
        btnNotification.backgroundColor = .clear
        btnNotifiInternal.backgroundColor = .clear
    }
}

//MARK:-
extension NotifiViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number : Int!
        if tableView == self.myTable {
            number = 3
        } else {
            number = 4
        }
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.myTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListNotifiCell", for: indexPath) as! ListNotifiCell
            return cell
        } else {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellDetailNotifi1", for: indexPath) as! CellDetailNotifi1
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellDetailNotifi2", for: indexPath) as! CellDetailNotifi2
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellDetailNotifi3", for: indexPath) as! CellDetailNotifi3
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell3", for: indexPath) as! EventCell3
                cell.numberDocs = 7
                cell.conFig()
                return cell
            default:
                break
            }
        }
        return UITableViewCell.init()
    }
}
