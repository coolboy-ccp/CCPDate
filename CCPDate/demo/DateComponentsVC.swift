//
//  DateComponentsVC.swift
//  CCPDate
//
//  Created by clobotics_ccp on 2019/8/27.
//  Copyright © 2019 cool-ccp. All rights reserved.
//

import UIKit

class DateComponentsVC: UIViewController {
    
    typealias DataSource = (title: String, desc: String)

    @IBOutlet weak var tableview: UITableView!
    
    private let titles = ["year", "month", "day", "hour", "minute", "second", "weekday", "weekDayOridinal", "weekOfMonth", "weekOfYear"]
    private let now = Date() + .month(1) + .day(6)
    private lazy var cpts: [Int] = {
        return [now.year, now.month, now.day, now.hour, now.minute, now.second, now.weekDay, now.weekDayOridinal, now.weekOfMonth, now.weekOfYear]
    }()
    
    private lazy var datasuorce: [DataSource] = {
        return titles.enumerated().map { (idx, title) in
            return (title, "\(cpts[idx])")
        }
    }()
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
    }

    
    private func setupHeader() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        label.text = "now: " + now.string()
        label.textAlignment = .center
        label.textColor = .black
        tableview.tableHeaderView = label
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
        cell?.textLabel?.text = data.title
        cell?.detailTextLabel?.text = data.desc
        return cell!
    }
    
    
}
