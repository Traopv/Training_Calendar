//
//  MonthViewController.swift
//  CalendarApp
//
//  Created by Apple on 9/30/20.
//

import UIKit

class MonthViewController: UIViewController {

    @IBOutlet weak var viewCollection: UIView!
    let viewCal = CalendarVC.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCal.wieghtView = Double(viewCollection.bounds.width)
        viewCal.heightView = Double(viewCollection.bounds.height)
        viewCal.view.frame = CGRect(x: 0.0, y: 0.0, width: viewCollection.bounds.width, height: viewCollection.bounds.height)
        viewCollection.addSubview(viewCal.view)
        viewCollection.bringSubviewToFront(viewCal.view)
        viewCal.indexType = 1
    }
}
