//
//  ReportViewController.swift
//  CalendarApp
//
//  Created by Apple on 10/13/20.
//

import UIKit

class ReportViewController: UIViewController {

    @IBOutlet weak var viewContent: UIView!
    let listReportView = ListReportView().fromNib(nibName: "ListReportView") as! ListReportView
    let listReportVC = ListReportViewController.init(nibName: "ListReportViewController", bundle: nil)
    var closurePushView: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conFig()
        
        listReportView.closurePushView = {
            self.closurePushView?()
        }
    }
    
    //MARK:-
    //MARK: config
    func conFig() {
        self.navigationController?.isNavigationBarHidden = true
        viewContent.frame = CGRect(x: 0, y: 0, width: viewContent.bounds.width, height: viewContent.bounds.height)
        listReportView.conFig()
        viewContent.addSubview(listReportView)
    }
}
