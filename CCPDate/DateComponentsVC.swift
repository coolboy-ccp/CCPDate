//
//  DateComponentsVC.swift
//  CCPDate
//
//  Created by clobotics_ccp on 2019/8/27.
//  Copyright © 2019 cool-ccp. All rights reserved.
//

import UIKit

class DateComponentsVC: UIViewController {
    
    typealias DataSource = (type: String, desc: String)

    @IBOutlet weak var tableview: UITableView!
    
    private lazy var datasuorce: [DataSource] = {
        let now = Date()
        return DescType.allKeys.map({ (type) -> DataSource in
            return ("\(type) \(now.string(formatter: .YMD))", now.weekDesc(type) + " " + now.monthDesc(type))
        })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension DateComponentsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return datasuorce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "DateComponentsDemoCell")
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "DateComponentsDemoCell")
        }
        let data = datasuorce[indexPath.row]
        cell?.textLabel?.text = data.type
        cell?.detailTextLabel?.text = data.desc
        return cell!
    }
    
    
}
