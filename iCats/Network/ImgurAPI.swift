//
//  ImgurAPI.swift
//  iCats
//
//  Created by Yuri on 12/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

class ImgurAPI {
    private static var clientId = "d631fb9dfad1aa6"
    
    
    private init () {}
    
    private static func getRequest() -> URLRequest {
        let url = URL(string: "https://api.imgur.com/3/gallery/search/?q=cats")!
        
        var request = URLRequest(url: url,timeoutInterval: 30)
        request.addValue("Client-ID \(clientId)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        return request
    }
    
    static func getCats(onComplete: @escaping (Result<[Cat], APIError>) -> Void) {
        let task = URLSession.shared.dataTask(with: getRequest()) { data, response, error in
          guard let data = data else {
              return onComplete(.failure(.invalidData))
          }
          
          guard let response = response as? HTTPURLResponse else {
              return onComplete(.failure(.badResponse))
          }
          
          guard response.statusCode == 200 else {
              return onComplete(.failure(.invalidStatusCode(statusCode: response.statusCode)))
          }
          
          guard error == nil else {
              return onComplete(.failure(.invalidData))
          }
            
            do {
                let cats = try JSONDecoder().decode(ImgurResponse<Cat>.self, from: data).data
                onComplete(.success(cats))
            } catch let error {
                debugPrint(error)
                onComplete(.failure(.invalidJson))
            }
        }

        task.resume()
    }
    
}
