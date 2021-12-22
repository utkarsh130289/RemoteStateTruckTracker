//
//  AppConstants.swift
//  TrucksTracker
//
//  Created by Utkarsh Goel on 17/12/21.
//

import Foundation

class AppConstants {
    
    static let AppName = "Remote State"
    
    static let RefreshIcon = "refresh_white"
    static let listViewImage = "listView"
    static let mapViewImage = "mapView"
    
    struct URLPaths {
        static let fetchTrucksList = "https://api.mystral.in/tt/mobile/logistics/searchTrucks?auth-company=PCH&companyId=33&deactivated=false&key=g2qb5jvucg7j8skpu5q7ria0mu&q-expand=true&q-include=lastRunningState,lastWaypoint"
    }
    
    struct API {
        static let API_Failure_Title = "Alert!"
        static let API_Failure_Message = "Unable to fetch data. Please try again later."
    }
    
}

