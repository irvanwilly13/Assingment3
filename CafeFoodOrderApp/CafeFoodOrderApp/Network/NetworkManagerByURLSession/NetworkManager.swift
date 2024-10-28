//
//  NetworkManager.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//

import Foundation
import UIKit

class NetworkManager {
    
    public static let shared = NetworkManager()
    private init() {}
    
    func requestData(url: URL, method: String = "GET", headers: [String: String] = [:], parameters: [String: Any]? = nil) async throws -> Data {
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        if let parameters = parameters {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }
    
    func fetchRequest<T: Codable>(endpoint: EndpointAPI, epecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void ) {
        Task {
            do {
                if let url = URL(string: endpoint.urlString) {
                    let result = try await self.requestData(url: url, method: endpoint.method().rawValue, headers: endpoint.headers, parameters: endpoint.parameters)
                    print("data berhasil di dapat \(result)")
                    
                    let items = try JSONDecoder().decode(T.self, from: result)
                    completion(.success(items)) // jika berhasil, kirim items melalui closer
                }
            } catch let error {
                completion(.failure(error)) // jika terjadi error, kirim error melalui closure
            }
        }
        
    }
}
