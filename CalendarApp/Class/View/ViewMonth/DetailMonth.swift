//
//  DetailMonth.swift
//  Demo
//
//  Created by Apple on 9/21/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class DetailMonth: UIView {
    
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var myTable: UITableView!
    var arrEvent : [Data] = [Data]()
    var currentDate = Date()
    
    //MARK:-
    //MARK: Setup
    func conFig() {
        lbDate.text = String(currentDate.toString(dateFormat: "dd-MM-yyyy"))
        layer.cornerRadius = 8
        layer.masksToBounds = true
        myTable.register(UINib.init(nibName: "CellDetailMonth", bundle: nil), forCellReuseIdentifier: "CellDetailMonth")
        
    }
    
    func fromNib(nibName : String, index : Int! = 0) -> UIView {
        let bundle = Bundle.main
        let nib = UINib(nibName: nibName, bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil)[index] as! UIView
        
        return nibView
    }
}

//MARK:-
extension DetailMonth: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrEvent.count == 0 {
            return 0
        } else {
            return arrEvent.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellDetailMonth", for: indexPath) as! CellDetailMonth
        cell.lbEvent.text = arrEvent[indexPath.row].title
        cell.lbTime.text = arrEvent[indexPath.row].startDate.toString(dateFormat: "HH:mm")
        return cell
    }
}
