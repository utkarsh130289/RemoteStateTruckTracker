//
//  TrucksModel.swift
//  TrucksTracker
//
//  Created by Utkarsh Goel on 19/11/21.
//

import Foundation

struct LastWayPointDTO: Decodable {
    let lat: Double
    let lng: Double
    let createTime: Double
    let speed: Double
    let ignitionOn: Bool
}

struct LastRunningStateDTO: Decodable {
    let stopStartTime: Double
    let truckRunningState: Int
}

struct TruckModel: Decodable {
    let id: Int
    let truckNumber: String
    let createTime: Double
    let lastWaypoint: LastWayPointDTO
    let lastRunningState: LastRunningStateDTO
}

struct ResponseCodeModel : Decodable {
    let responseCode : Int
    let message : String
}

struct TrucksListResponseModel: Decodable {
    let responseCode : ResponseCodeModel
    var data : [TruckModel]
}
