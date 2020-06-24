//
//  NetworkManager.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

enum Endpoint {
    case filters
    case coctails(category: String)
    
    var parameters: String {
        switch self {
        case .filters:
            return "list.php?c=list"
        case .coctails(let category):
            return "filter.php?c=\(category.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!)"
        }
    }
}

class NetworkManager {
    
    private let urlBase = "https://www.thecocktaildb.com/api/json/v1/1/"
    
    private func createRequest(endpoint: String) -> URLRequest? {
        print(endpoint)
        if let url = URL(string: endpoint) {
            var request = URLRequest(url : url)
            request.httpMethod = "GET"
            return request
        }
        return nil
    }
    
    func getData<T: Decodable>(target: Endpoint, completion: @escaping (Result<T, ApiResponse>) -> Void) {
        
        let url = urlBase + target.parameters
        guard let request = createRequest(endpoint: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data else {
                completion(.failure(.failed))
                return
            }
            do {
                let res = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    print(res)
                    completion(.success(res))
                }
            }
            catch {
                completion(.failure(.failed))
            }
        }
        task.resume()
    }
}
