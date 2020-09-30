//
//  HomeViewController.swift
//  AppCalendar
//
//  Created by Apple on 9/29/20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    var views : [UIView] = [UIView]()
    let dayVC = DayViewController.init()
    let monthVC = MonthViewController.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        // ẩn navigationBar
        self.navigationController?.isNavigationBarHidden = true
        //Setup Segment
        setupSegment()
        print("==> size view",views[0].bounds.size)
    }
    
    //MARK:-
    //MARK: Setup
    func setupSegment(){
        dayVC.view.frame = CGRect(x: 0, y: 0, width: viewContainer.bounds.width, height: viewContainer.bounds.height)
        monthVC.view.frame = CGRect(x: 0, y: 0, width: viewContainer.bounds.width, height: viewContainer.bounds.height)
        views.append(dayVC.view)
        views.append(monthVC.view)
            for view in views {
                viewContainer.addSubview(view)
            }
        viewContainer.bringSubviewToFront(views[0])
    }
    
    //MARK:-
    //MARK: Button Function
    @IBAction func selectedSegment(_ sender: UISegmentedControl) {
        viewContainer.bringSubviewToFront(views[sender.selectedSegmentIndex])
    }
}
