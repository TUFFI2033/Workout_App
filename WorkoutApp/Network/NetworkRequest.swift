//
//  NetworkRequest.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 11/11/2023.
//

import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    private init() {}
    
    
    func requestData(latitude: Double, longitude: Double, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = "11dea55c0bcc1ca6fa1c376b180201bb"
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(key)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(error))
                } else {
                    guard let data else { return }
                    completion(.success(data))
                }
            }
        }.resume()
    }
}
