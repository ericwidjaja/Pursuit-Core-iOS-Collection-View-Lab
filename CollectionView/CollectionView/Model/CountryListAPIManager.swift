//
//  CountryListAPIManager.swift
//  CollectionView
//
//  Created by Eric Widjaja on 9/26/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import Foundation
class CountryListAPIManager {
    
    //MARK: - Static Properties
    static let manager = CountryListAPIManager()
    
    //MARK: - Instance Methods
    func getCountry(searchWord: String, completionHandler: @escaping (Result<[CountryList], AppError>) -> () ) {
         var str = "united"
         if searchWord != "" {str = searchWord
         } else {
            str = "united"
         }
         guard let url = URL(string:  "https://restcountries.eu/rest/v2/name/\(str.lowercased())") else { completionHandler(.failure(.badURL))
                        return
         }
    
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error) :
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let countries = try JSONDecoder().decode([CountryList].self, from: data)
                    completionHandler(.success(countries))
                } catch { completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    static func getFlagImageURLStr(from code: String) -> String {
        return "https://www.countryflags.io/\(code.lowercased())/shiny/64.png"
    }
}
