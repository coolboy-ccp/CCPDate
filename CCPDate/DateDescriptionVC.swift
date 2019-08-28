//
//  ViewController.swift
//  CCPDate
//
//  Created by clobotics_ccp on 2019/8/27.
//  Copyright © 2019 cool-ccp. All rights reserved.
//

import UIKit

class DateDescriptionVC: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    
    typealias DataSource = (string: String, local: String)
    
    private let now = Date()
    
    private var titleDesc = "DateDescription-China" {
        didSet {
            if titleDesc == oldValue { return }
            self.title = titleDesc
            self.tableview.reloadData()
        }
    }
    
    private lazy var datasource: [DataSource] = {
        return data(in: .china)
    }()
    
    private func data(in area: Area) -> [DataSource] {
        return CCPDateFormatter.allKeys.map({ (df) -> (String, String) in
            return (now.string(formatter: df, interval: .dot, area: area), now.localString(formatter: df, area: area))
        })
    }
    
    @IBAction func areaType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            datasource = data(in: .china)
            titleDesc = "DateDescription-China"
        case 1:
            datasource = data(in: .usa)
            titleDesc = "DateDescription-USA"
        case 2:
            datasource = data(in: .en)
            titleDesc = "DateDescription-EN"
        default: break
        }
    }
    
    private func updateIfNeed() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date1 = Date()
//        let date2 = Date(timeIntervalSince1970: date1.timeIntervalSince1970 - 3600)
//        let date3 = Date(timeIntervalSince1970: date1.timeIntervalSince1970 + 3)
//        let date4 = Date(timeIntervalSince1970: date1.timeIntervalSince1970 + 60)
//        let date5 = Date(timeIntervalSince1970: date1.timeIntervalSince1970 + 3600)
//        let date6 = Date(timeIntervalSince1970: date1.timeIntervalSince1970 + 3600 * 24)
//        print(date2 - date1, date3 - date1, date4 - date1, date5 - date1, date6 - date1)
        print(date1,date1 + AddUnit.day(1))
    }
}

extension DateDescriptionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "TimeShowDemoCell")
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "TimeShowDemoCell")
        }
        let data = datasource[indexPath.row]
        cell?.textLabel?.text = data.string
        cell?.detailTextLabel?.text = data.local
        return cell!
    }
}



