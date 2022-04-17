//
//  NetworkManger.swift
//  friends
//
//  Created by Mahbubur Rashid Leon on 16/4/22.
//

import Foundation
import UIKit

final class NetworkManger {
    static let shared = NetworkManger()
    private init() {}
    
    typealias SuccessCompletionHandler = ((Data) -> Void)
    typealias FailureCompletionHandler = ((ErrorRequest) -> Void)
    
    /**
     Generic method for getting data from API.
     - parameter url: API URL in String format.
     - parameter type: GET or POST request type.
     - parameter params: Pass the parameter to get the valid response data in `Data` format.
     - parameter header: Specify any headers if needed in [String : String] format.
     - parameter onSuccess: This is a `@escaping closure` for getting success response.
     - parameter onFailure: This is a `@escaping closure` for getting failure response.
     - returns: This method does not have any return statement.
     */
    func getDataFromApi(for url: String,
                        of type: RequestType,
                        with params: Data? = nil,
                        needs header: [String : String]? = nil,
                        onSuccess: @escaping SuccessCompletionHandler,
                        onFailure: @escaping FailureCompletionHandler) {
        let urlSession = URLSession(configuration: .default)
        
        guard let url = URL(string: url) else {
            onFailure(.invalidURL)
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        if let params = params {
            request.httpBody = params
        }
        if let header = header {
            request.allHTTPHeaderFields = header
        }
        switch type {
        case .GET:
            request.httpMethod = "GET"
        case .POST:
            request.httpMethod = "POST"
        }
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                onFailure(.invalidResponse)
                return
            }
            guard 200 ..< 300 ~= response.statusCode else { // Filter http requests for valid code only
                onFailure(.invalidStatusCode("Network error. Please try again later.", response.statusCode))
                return
            }
            guard let data = data else {
                onFailure(.noDataAvailable)
                return
            }
            onSuccess(data)
        }
        task.resume()
    }
    
    /**
     For load image into `ImageView` from `API`
     - parameter url: Get URL in `String` format.
     - parameter imageView: `UIImageView` where the image will be loaded
     - returns: This method does not have any return statement
     */
    func loadImage(from url: String, into imageView: UIImageView) {
        guard let imageURL = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else {
                DispatchQueue.main.async {
                    imageView.image = UIImage(named: "DefaultHumanFaceImage") //loading default image incase of there is no image loaded
                }
                return
            }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
}

enum RequestType {
    case GET
    case POST
}

enum ErrorRequest: Error {
    case invalidURL
    case invalidResponse
    case noDataAvailable
    case cannotProcessData
    case invalidStatusCode(String, Int)
    case otherError(Error?)
}
