//
//  BaseApi.swift
//  AlteaCareTest
//
//  Created by Dicky Geraldi on 18/11/22.
//

import Alamofire

enum ApiError: Error {
    case forbidden
    case notFound
    case internalServerError
    case badRequest
}

class BaseAPIService {
    
    static func request(_ urlConvertible: URLRequestConvertible, completion: @escaping ([String: Any]?) -> Void, onError: @escaping (Error) -> Void) {
        print("Request to: \(urlConvertible.urlRequest?.url?.absoluteString ?? "")")
        AF.request(urlConvertible).responseString(queue: .main, encoding: .utf8) { response in
            switch response.result {
            case .success(let value):
                switch response.response?.statusCode {
                case 200:
                    print("Response String: \(value)")
                    completion(value.convertToDictionary())
                case 400:
                    onError(ApiError.badRequest)
                case 403:
                    onError(ApiError.forbidden)
                case 404:
                    onError(ApiError.notFound)
                case 500:
                    onError(ApiError.internalServerError)
                case .none:
                    break
                case .some(_):
                    break
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
}

enum BaseRouter: URLRequestConvertible {
    
    case getDoctorData

    var path: String {
        switch self {
        case .getDoctorData:
            return "c9a2b598-9c93-4999-bd04-0194839ef2dc"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getDoctorData:
            return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        default: return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        if let url = URL(string: "https://run.mocky.io/v3/\(path)") {
            var request = URLRequest.init(url: url)
            request.httpMethod = method.rawValue
            request.timeoutInterval = TimeInterval(10*1000)
            return try URLEncoding.default.encode(request,with: parameters)
        } else {
            return URLRequest(url: URL(string: "")!)
        }
    }
}
