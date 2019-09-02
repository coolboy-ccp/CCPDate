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
    
    private func setupHeader() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        label.text = "now: " + now.string()
        label.textAlignment = .center
        label.textColor = .black
        tableview.tableHeaderView = label
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
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



