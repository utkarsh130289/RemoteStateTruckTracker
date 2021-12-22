//
//  TrucksListViewController.swift
//  TrucksTracker
//
//  Created by Utkarsh Goel on 19/11/21.
//

import UIKit

class TrucksListViewController: UITableViewController {
    
    var trucksModelList : [TruckModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .lightGray
        tableView.register(UINib(nibName: "TrucksListTableViewCell", bundle: nil), forCellReuseIdentifier: "truckCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        tableView.dataSource = self
//        tableView.delegate = self
    }
}

extension TrucksListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count: \(trucksModelList.count)")
        return trucksModelList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "truckCell", for: indexPath) as! TrucksListTableViewCell
        cell.configureCell(truckModel: trucksModelList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "trucksMapView") as! TrucksMapViewController
        controller.trucksModelList = trucksModelList
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViwe Did Scroll")
    }
}

