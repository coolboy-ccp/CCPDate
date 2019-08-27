//
//  ViewController.swift
//  CCPDate
//
//  Created by clobotics_ccp on 2019/8/27.
//  Copyright © 2019 cool-ccp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    
    typealias DataSource = (string: String, local: String)
    
    private let now = Date()
    
    private var titleDesc = "DateShow-China" {
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
            titleDesc = "DateShow-China"
        case 1:
            datasource = data(in: .usa)
            titleDesc = "DateShow-USA"
        case 2:
            datasource = data(in: .en)
            titleDesc = "DateShow-EN"
        default: break
        }
    }
    
    private func updateIfNeed() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UITableViewDataSource {
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



