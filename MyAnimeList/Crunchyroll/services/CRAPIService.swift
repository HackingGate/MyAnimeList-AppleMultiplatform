//
//  CRAPIService.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/11.
//

import Foundation

public struct CRAPIService {
    let baseURL = URL(string: "https://api.crunchyroll.com/")!
    public static let shared = CRAPIService()
    let decoder = JSONDecoder()
    public enum APIError: Error {
        case noResponse
        case jsonDecodingError(error: Error)
        case networkError(error: Error)
    }
    public enum Endpoint {
        case listCollections, listMedia, info
        func path() -> String {
            switch self {
            case .listCollections:
                return "list_collections.0.json"
            case .listMedia:
                return "list_media.0.json"
            case .info:
                return "info.0.json"
            }
        }
    }
    public func GET<T: Codable>(endpoint: Endpoint,
                         params: [String: String]?,
                         completionHandler: @escaping (Result<T, APIError>) -> Void) {
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "locale", value: "enUS"),
            URLQueryItem(name: "version", value: "2.6.0"),
            URLQueryItem(name: "limit", value: "1000"),
            URLQueryItem(name: "offset", value: "0"),
        ]
        if let params = params {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noResponse))
                }
                return
            }
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.networkError(error: error!)))
                }
                return
            }
            do {
                let object = try self.decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(object))
                }
            } catch let error {
                DispatchQueue.main.async {
                    #if DEBUG
                    print("JSON Decoding Error: \(error)")
                    #endif
                    completionHandler(.failure(.jsonDecodingError(error: error)))
                }
            }
        }
        task.resume()
    }
}
