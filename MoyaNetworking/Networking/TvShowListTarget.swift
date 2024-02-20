//
//  TvShowListTarget.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 19/2/24.
//

import Moya

enum TvShowListTarget {
    case popular
    case airingToday
    case onTheAir
    case topRated
    
}

extension TvShowListTarget: TargetType {
    var baseURL: URL {
        return URL(string: Constants.API.baseUrl) ?? URL(string: "https://fallback.url")!
    }
    private var pathComponent: String {
           switch self {
           case .popular: return "popular"
           case .airingToday: return "airing_today"
           case .onTheAir: return "on_the_air"
           case .topRated: return "top_rated"
           }
       }

    var path: String {
           return "tv/\(pathComponent)"
       }
    
    var method: Moya.Method { return .get }
    
    var task: Task {
        return .requestParameters(parameters: ["api_key": "\(Constants.API.apiKey)"], encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data { return Data() }
}

