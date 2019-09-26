//
//  CountryList.swift
//  CollectionView
//
//  Created by Eric Widjaja on 9/26/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.

import Foundation
import UIKit



struct CountryList: Codable {
    var name: String
    var flag: String
    var capital: String
    var population: Int
    var currencies: [Currency]
    
    static func getInfo(from data: Data) -> [CountryList]? {
        do {
            let countries = try JSONDecoder().decode([CountryList].self, from: data)
            return countries
        } catch let decodeError {
            fatalError("Could not decode \(decodeError)")
        }
        
}
    
    
}

struct Currency: Codable {
    var code: String
    var name: String
    var symbol: String
    
}
