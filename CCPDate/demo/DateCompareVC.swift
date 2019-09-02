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
    
    private typealias Result = (title: String, desc: String)
    private typealias DataSource = [[Result]]
    
    
    private let now = Date()
    private let titles = ["year", "month", "week", "day", "hour", "minute", "second"]
    private let units: [AddUnit] = [.year(1), .month(1), .week(1), .day(1), .hour(1), .minute(1), .second(1)]
    private lazy var addResults: [Date] = {
        return units.map {
            return now + $0
        }
    }()
    
    private lazy var subResults: [SubResult] = {
        return addResults.map {
            return $0 ~- now
        }
    }()
    
    private lazy var adds: [Result] = {
        return titles.enumerated().map { (idx, title) in
            return (title, addResults[idx].string())
        }
    }()
    
    private lazy var subs: [Result] = {
        return titles.enumerated().map { (idx, title) in
            return (title, "\(subResults[idx])")
        }
    }()
    
    private lazy var datasource: DataSource = {
        return [adds, subs]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        // Do any additional setup after loading the view.
    }
    
    private func setupHeader() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        label.text = "now: " + now.string()
        label.textAlignment = .center
        label.textColor = .black
        tableview.tableHeaderView = label
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension DateCompareVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "DateCompareDemoCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "DateCompareDemoCell")
        }
        let data = datasource[indexPath.section][indexPath.row]
        cell?.textLabel?.text = data.title
        cell?.detailTextLabel?.text = data.desc
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "demo for add"
        case 1:
            return "demo for sub"
        default:
            return nil
        }
    }
    
}
