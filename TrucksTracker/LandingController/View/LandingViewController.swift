//
//  LandingViewController.swift
//  TrucksTracker
//
//  Created by Utkarsh Goel on 17/12/21.
//

import Foundation
import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var listContainerView: UIView!
    @IBOutlet weak var mapContainerView: UIView!
    
    private var listViewController: TrucksListViewController = TrucksListViewController()
    private var mapViewController: TrucksMapViewController = TrucksMapViewController()
    
    let listViewImage = UIImage(named: AppConstants.listViewImage)
    let mapViewImage = UIImage(named: AppConstants.mapViewImage)
    
    let viewModel = LandingViewModel()
    var trucksModelList : [TruckModel] = []
    
    enum Segues {
        static let ToListViewController = "toListVC"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = AppConstants.AppName
        
        mapContainerView.alpha = 0
        
        setupBarButtonItems()
        setupViewModel()
    }
    
    func setupViewModel() {
        viewModel.success = {
            DispatchQueue.main.async {
                self.trucksModelList = self.viewModel.dataSource
                self.setupContainerViews()
            }
        }

        viewModel.failure = {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: AppConstants.API.API_Failure_Title, message: AppConstants.API.API_Failure_Title , preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            }
        }
        refreshApiCall(sender: UIBarButtonItem())
    }
    
    
    
    func setupContainerViews() {
        
        listViewController.trucksModelList = self.trucksModelList
        listViewController.tableView.reloadData()
        
        mapContainerView.subviews.forEach { $0.removeFromSuperview() }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mapvc = storyBoard.instantiateViewController(withIdentifier: "mapViewController") as? TrucksMapViewController
        if let mapvc = mapvc{
            mapvc.trucksModelList = self.trucksModelList
            mapvc.view.bounds = mapContainerView.bounds
            mapvc.view.frame.origin = .zero
            mapvc.loadMapView()
            mapContainerView.addSubview(mapvc.view)
        }
    }
    
    func setupBarButtonItems() {
        
        let refreshButton = UIBarButtonItem(image: UIImage(named: AppConstants.RefreshIcon), style: .plain, target: self, action:#selector(refreshApiCall(sender:)))
        let viewsSwitchButton = UIBarButtonItem(image: mapViewImage, style: .plain, target: self, action:  #selector(switchViewsButtonAction(sender:)))
        
        self.navigationItem.rightBarButtonItems  = [viewsSwitchButton, refreshButton]
    }
    
    @objc func refreshApiCall(sender: UIBarButtonItem) {
        
        viewModel.fetchTrucksList()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.ToListViewController {
            let destVC = segue.destination as! TrucksListViewController
            destVC.trucksModelList = self.trucksModelList
            listViewController = destVC
        }else{
            let destVC = segue.destination as! TrucksMapViewController
            destVC.trucksModelList = self.trucksModelList
        }
    }
    
    @objc func switchViewsButtonAction(sender: UIBarButtonItem) {
        if sender.image == mapViewImage{
            sender.image = listViewImage
            mapContainerView.alpha = 1
            listContainerView.alpha = 0
        }else{
            sender.image = mapViewImage
            mapContainerView.alpha = 0
            listContainerView.alpha = 1
        }
    }
}
