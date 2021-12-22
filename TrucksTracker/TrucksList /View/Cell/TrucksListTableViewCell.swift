//
//  TrucksListTableViewCell.swift
//  TrucksTracker
//
//  Created by Utkarsh Goel on 19/11/21.
//

import UIKit

class TrucksListTableViewCell: UITableViewCell {
    @IBOutlet weak var TruckNumberLbl: UILabel!
    @IBOutlet weak var TruckLastUpdatedLbl: UILabel!
    @IBOutlet weak var TruckRunStopStateLbl: UILabel!
    @IBOutlet weak var TruckSpeedLbl: UILabel!
    
    func configureCell(truckModel:TruckModel) {
        self.TruckNumberLbl.text = truckModel.truckNumber
        self.TruckRunStopStateLbl.text = self.getTruckRunStopStateStr(truckLastRunningState: truckModel.lastRunningState)
        self.TruckLastUpdatedLbl.text = self.getTruckLastUpdatedStr(createdTimeStamp: truckModel.lastWaypoint.createTime)
        self.TruckSpeedLbl.text = "\(truckModel.lastWaypoint.speed.rounded()) Km/h"
    }
    
    func getTruckRunStopStateStr(truckLastRunningState:LastRunningStateDTO) -> String {
        
        var movingStatus = ""
        if truckLastRunningState.truckRunningState != 0 {
            movingStatus = "Running"
        }
        else
        {
            movingStatus = "Stopped"
        }
        
        return "\(movingStatus) since last \(getNumberOfDays(timestamp: truckLastRunningState.stopStartTime)) days"
    }
    
    func getTruckLastUpdatedStr(createdTimeStamp:Double) -> String {
        return "\(getNumberOfDays(timestamp: createdTimeStamp)) days ago"
    }
    
    func getNumberOfDays(timestamp: Double) -> String {
        let date1 = NSDate(timeIntervalSince1970: timestamp)

        let secondsBetween: TimeInterval = date1.timeIntervalSinceNow
        let numberOfDays = Double(secondsBetween / 86400)
        
        let daysStr = String(format: "%.0f", numberOfDays)
        return daysStr
    }
    
}
