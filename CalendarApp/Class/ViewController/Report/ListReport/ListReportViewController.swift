//
//  ListReportViewController.swift
//  CalendarApp
//
//  Created by Apple on 10/13/20.
//

import UIKit

class ListReportViewController: UIViewController {

    @IBOutlet weak var btnPre: UIButton!
    @IBOutlet weak var btnTitle: UILabel!
    @IBOutlet weak var lbDecription: UILabel!
    @IBOutlet weak var viewContent: UIView!
    
    let listReportView = ListReportView().fromNib(nibName: "ListReportView") as! ListReportView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conFig()
    }
    
    //MARK:-
    //MARK: config
    func conFig() {
        viewContent.frame = CGRect(x: 0, y: 0, width: viewContent.bounds.width, height: viewContent.bounds.height)
        listReportView.conFig()
        viewContent.addSubview(listReportView)
    }
    
    //MARK:-
    //MARK: button function
    @IBAction func backReport(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
