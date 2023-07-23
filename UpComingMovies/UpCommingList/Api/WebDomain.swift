//
//  WebDomain.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 17/04/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import SwiftApiSDK
import Foundation

public struct ServerConfig {
    public static let dateFormat = "yyyy-MM-dd"
    public static let imagesBaseUrl = "https://image.tmdb.org/t/p/w185/"
}

public struct WebDomain: WebDomainProtocol {
    enum Domain: String {
    case producao = "https://api.themoviedb.org/3/"
    case homolog = "https://homolog.themoviedb.org/3/"
    case dev = "localhost://api.themoviedb.org/3/"
    }
    
    public init() { }

    public func domainForBundle() -> String {
        if let bundleID = Bundle.main.bundleIdentifier {
            if bundleID.range(of: "homolog") != nil {
                return Domain.homolog.rawValue
            }
            if bundleID.range(of: "dev") != nil {
                return Domain.dev.rawValue
            }
        }
        return Domain.producao.rawValue
    }
}
