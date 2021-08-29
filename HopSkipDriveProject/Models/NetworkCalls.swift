//
//  NetworkCalls.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/26/21.
//

import Foundation

class NetworkCalls {
    func getRides(completionHandler: @escaping (_ allRides: [Ride]) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        
        guard let url = URL(string: "https://storage.googleapis.com/hsd-interview-resources/simplified_my_rides_response.json") else { return }
        
        //Turns json into swift objects.
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                
                //specifying "rides" section of json
                let allRidesData = try JSONSerialization.data(withJSONObject: json["rides"] as! [[String:Any]])

                let allRidesArr = try decoder.decode([Ride].self, from: allRidesData)

                completionHandler(allRidesArr)
                
            } catch let error {
                completionHandler([])
                print(error)
            }
        }

        task.resume()
            
    }
}
