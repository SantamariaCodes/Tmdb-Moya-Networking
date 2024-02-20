import Moya

enum MovieListTarget {
    case popularMovies
    case topRated
    case upComing
    case nowPlaying
    // Add other cases as needed, e.g., movie details, search, etc.
}

extension MovieListTarget: TargetType {
    var baseURL: URL {
        return URL(string: Constants.API.baseUrl) ?? URL(string: "https://fallback.url")!
    }
    private var pathComponent: String {
           switch self {
           case .popularMovies: return "popular"
           case .topRated: return "top_rated"
           case .upComing: return "upcoming"
           case .nowPlaying: return "now_playing"
           }
       }

    var path: String {
           return "movie/\(pathComponent)"
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
