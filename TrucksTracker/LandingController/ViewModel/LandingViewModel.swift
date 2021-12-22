//
//  LandingViewModel.swift
//  TrucksTracker
//
//  Created by Utkarsh Goel on 19/11/21.
//

import Foundation



class LandingViewModel {
    
    var apiResponse: TrucksListResponseModel?
    
    var dataSource: [TruckModel] {
        apiResponse?.data ?? []
    }
    
    func fetchTrucksList() {// -> TrucksListResponseModel
        
        let url = URL(string: AppConstants.URLPaths.fetchTrucksList)!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            self.parseData(data: data)
        }

        task.resume()
    }
    
    func parseData(data:Data?) {
        if let data = data {
            do {
                let response = try JSONDecoder().decode(TrucksListResponseModel.self, from: data)
                apiResponse = response
                if apiResponse?.responseCode.responseCode == 200 {
                    self.success?()
                }else{
                    self.failure?()
                }
            } catch let error {
                print("decode failure: \(error.localizedDescription)")
            }
        } else {
            print("data failure")
        }
    }
    
    var success: (()->Void)?
    var failure: (()->Void)?

    
}


