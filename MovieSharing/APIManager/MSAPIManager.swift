//
//  APIManager.swift
//  MovieSharing
//
//  Created by Bhargow on 12.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import Foundation

// Youtube search parameters definition

enum APIParameters: String {
    case responseContentType = "part"
    case searchKeyWord = "q"
    case maxResults = "maxResults"
    case apiKey = "key"
    
}

enum APIManagerError {
    case invalidURL
    case invalidResponse
    case urlSessionError
    case invalidDataFormat
}

class MSAPIManager {

    var session: URLSession!
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func get(urlString: inout String, urlParameters:[APIParameters : Any], completionHandler: @escaping ([String : Any]) -> Void, errorOccoured:@escaping (APIManagerError) -> Void) {
        
        
        for (key, value) in urlParameters {
            if key == urlParameters.keys.first {
                urlString.append("\(key.rawValue)=\(value)")
            } else {
                urlString.append("&\(key.rawValue)=\(value)")
            }
        }
        
        if let encodedUrlSting = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            urlString = encodedUrlSting
        }
        
        guard let url = URL(string: urlString) else {
            errorOccoured(.invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Accept" : "application/json"]
    
        URLSession.shared.dataTask(with: request) { (responseData, urlResponse, error) in
            if let err = error {
                debugPrint("urlSessionError \(err.localizedDescription)")
                errorOccoured(.urlSessionError)
            }
            
            guard let data = responseData  else {
                debugPrint("invalidResponse")
                errorOccoured(.invalidResponse)
                return
            }
            
            do {
                if let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] {
                    completionHandler(jsonData)
                }
            } catch let err {
                debugPrint("invalidDataFormat \(err.localizedDescription)")
                errorOccoured(.invalidDataFormat)
            }
        }.resume()
    }
}
