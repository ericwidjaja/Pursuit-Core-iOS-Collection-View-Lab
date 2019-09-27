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
    var currencies: [CurrencyInfo]
    var alpha2Code: String?
    var imageURL: String {
        if alpha2Code != nil || alpha2Code != "" {
            return "https://www.countryflags.io/\(alpha2Code!.lowercased())/flat/64.png"
        } else {
            return "no Image"
        }
    }
}

struct CurrencyInfo: Codable {
    var symbol: String?
}
