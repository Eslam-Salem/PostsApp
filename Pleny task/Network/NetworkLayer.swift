//
//  NetworkLayer.swift
//  Pleny task
//
//  Created by Eslam Salem on 20/09/2023.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case serializationError
    case unknownError
}

class NetworkLayer {
    static func callApi<Model: Decodable>(with endPoint: String, httpMethod: HTTPMethod, body: [String: Any]? = nil, params: [String: Any]? = nil) -> AnyPublisher<Model, NetworkError> {
        var urlString = AppConstants.baseURL + endPoint
        // Append query parameters to the URL, if any
         if let params = params {
             let queryItems = params.map { key, value in
                 URLQueryItem(name: key, value: "\(value)")
             }
             if var urlComponents = URLComponents(string: urlString) {
                 urlComponents.queryItems = queryItems
                 if let queryURL = urlComponents.url {
                     urlString = queryURL.absoluteString
                 }
             }
         }
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Append bodyto the URL, if any
        if let body = body {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body)
            } catch {
                return Fail(error: NetworkError.serializationError).eraseToAnyPublisher()
            }
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Model.self, decoder: JSONDecoder())
            .mapError { error in
                        if let networkError = error as? NetworkError {
                            return networkError
                        } else {
                            return NetworkError.unknownError
                        }
                    }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
