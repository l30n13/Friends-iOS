//
//  FriendListVM.swift
//  friends
//
//  Created by Mahbubur Rashid Leon on 17/4/22.
//

import Foundation
import UIKit

class FriendListVM {
    public private (set) var numberOfSections: Int = 1
    public private (set) var numberOfItemsInSection: Int = 0
    
    private let dispatchGroup = DispatchGroup()
    private let dispatchSemaphore = DispatchSemaphore(value: 1)
    
    var friendsList: [ResultsModel] = []
    
    func fetchMyFriends(completion: @escaping(([ResultsModel]) -> Void)) {
        for _ in 0...20 {
            DispatchQueue.global(qos: .default).async { [weak self] in
                self?.dispatchGroup.enter()
                self?.dispatchSemaphore.wait()
                NetworkManger.shared.getDataFromApi(for: "https://randomuser.me/api/", of: .GET) { [weak self] (response) in
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(FriendListResponseModel.self, from: response)
                        debugPrint(data)
                        self?.friendsList.append(data.results![0])
                    } catch {
                        debugPrint(error)
                    }
                    self?.dispatchGroup.leave()
                    self?.dispatchSemaphore.signal()
                } onFailure: { [weak self] (error) in
                    var message = ""
                    switch error {
                    case .invalidURL:
                        message = "Invalid URL. Please your API."
                    case .invalidResponse:
                        message = "Invalid response. Please try again later."
                    case .noDataAvailable:
                        message = "No data available. Please try again later."
                    case .cannotProcessData:
                        message = "Data cannot be processed at the moment. Please try again later."
                    case .invalidStatusCode(let errorMessage, let statusCode):
                        message = "Status code is:\(statusCode)\n\(errorMessage)"
                    case .otherError(let error):
                        debugPrint(error ?? "")
                        message = error?.localizedDescription ?? ""
                    }
                    debugPrint(message)
                    self?.dispatchGroup.leave()
                    self?.dispatchSemaphore.signal()
                }
            }
        }
        
        dispatchGroup.notify(queue: .global()) { [weak self] in
            debugPrint(self?.friendsList.count ?? 0)
            if let list = self?.friendsList.prefix(10) {
                self?.numberOfItemsInSection = list.count
                self?.friendsList = Array(list)
                completion(Array(list))
            }
            debugPrint(self?.friendsList.count ?? 0)
        }
    }
}
