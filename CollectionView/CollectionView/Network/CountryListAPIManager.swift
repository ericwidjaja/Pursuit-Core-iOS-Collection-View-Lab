//
//  CountryListAPIManager.swift
//  CollectionView
//
//  Created by Eric Widjaja on 9/26/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import Foundation
class CountryListAPIManager {
    private init() {}
    
    static let shared = CountryListAPIManager()
    
    func getCountry(searchWord: String, completionHandler: @escaping (Result<[CountryList], AppError>) -> Void) {
        let urlStr = "https://restcountries.eu/rest/v2/name/united\(searchWord)"
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error) :
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let podcastInfo = try JSONDecoder().decode(CountryInfo.self, from: data)
                    completionHandler(.success(podcastInfo.results))
                } catch {
                completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
}
