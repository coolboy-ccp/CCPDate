//
//  DateCompareVC.swift
//  CCPDate
//
//  Created by clobotics_ccp on 2019/8/28.
//  Copyright © 2019 cool-ccp. All rights reserved.
//

import UIKit

class DateCompareVC: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    typealias DataSource = [String]
    
//    private lazy var datasource: [DataSource] {
//        let date = Date()
//        let addUnits = [AddUnit.year(1), AddUnit.month(1), AddUnit.day(1), AddUnit.hour(1), AddUnit.minute(1), AddUnit.second(1)]
//        let adds: [Date]  = addUnits.map { return date + $0 }
//        let subs: [SubResult] = adds.map { $0 - date }
//        
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
