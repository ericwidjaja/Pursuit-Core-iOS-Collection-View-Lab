//
//  AppError.swift
//  CollectionView
//
//  Created by Eric Widjaja on 9/26/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.

import Foundation
enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}
