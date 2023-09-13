//
//  NetworkService.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 14.09.2023.
//

import Foundation

// MARK: - NetworkServiceProtocol

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Singleton to have access for this class anywhere
    
    static let shared = NetworkService()
    
    // MARK: - URLSession and Decoder
    
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    // MARK: - Generic function to make universal requests
    
    func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Sam ti Invalid", code: 0, userInfo: nil)))
                return
            }
            do {
                let decodedData = try self.decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
