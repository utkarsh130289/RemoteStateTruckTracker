//
//  TrucksMapViewController.swift
//  TrucksTracker
//
//  Created by Utkarsh Goel on 26/11/21.
//

import UIKit
import MapKit

class TrucksMapViewController : UIViewController{
    
    @IBOutlet var mapView: MKMapView!
    
    var trucksModelList : [TruckModel] = []
    var annotationsList : [MKAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
    }
    
    func loadMapView() {
        self.prepareAnnotationsList(truckModels: self.trucksModelList)
        if (self.annotationsList != nil) {
            mapView.addAnnotations(self.annotationsList)
            self.mapView.showAnnotations(self.annotationsList, animated: true)
        }
    }
    
    func prepareAnnotationsList(truckModels: [TruckModel]) {
        annotationsList.removeAll()
        for truckModel in truckModels {
            let location = CLLocationCoordinate2D(latitude: truckModel.lastWaypoint.lat,longitude: truckModel.lastWaypoint.lng)
            let annotaion = MKTruckPointAnnotation()
            annotaion.coordinate = location
            annotaion.title = truckModel.truckNumber
            annotaion.isRunning = (truckModel.lastRunningState.truckRunningState != 0) ? true : false
            annotationsList.append(annotaion)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        }
}

extension TrucksMapViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is MKTruckPointAnnotation) {
            return nil
        }
        
        let annotationObj = annotation as! MKTruckPointAnnotation
        
        let annotationIdentifier = "TruckIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotationObj, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotationObj
        }
        
        if (annotationObj.isRunning == false) {
            let pinImage = UIImage(named: "truck_stop")
            annotationView!.image = pinImage
        }
        else {
            let pinImage = UIImage(named: "truck_run")
            annotationView!.image = pinImage
        }
        
        return annotationView
    }
}
