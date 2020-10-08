//
//  EventCell3.swift
//  CalendarApp
//
//  Created by ELSAGA-MACOS on 10/7/20.
//

import UIKit

class EventCell3: UITableViewCell {

    @IBOutlet weak var myTable: UITableView!
    var numberDocs : Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- ConFig
    func conFig(){
        myTable.register(UINib.init(nibName: "DocumentCell", bundle: nil), forCellReuseIdentifier: "DocumentCell")
    }
}

//MARK:-
extension EventCell3: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberDocs
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath) as! DocumentCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  detailMonth : DetailMonth = DetailMonth().fromNib(nibName: "DetailMonth", index: 0) as! DetailMonth
        detailMonth.conFig()
        let klc = KLCPopup.init(contentView: detailMonth)
        klc?.showType = .bounceInFromLeft
        klc?.dismissType = .bounceOutToTop
        klc?.maskType = .dimmed
        klc?.shouldDismissOnBackgroundTouch = true
        klc?.show()
    }
}
