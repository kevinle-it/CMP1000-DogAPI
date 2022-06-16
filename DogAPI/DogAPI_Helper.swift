//
//  DogAPI_Helper.swift
//  DogAPI
//
//  Created by Tri Le on 6/15/22.
//

import Foundation

enum DogBreedsData{
    case success([String:[String]])
    case failure(Error)
}

class DogAPI_Helper {
    private static let baseURL = URL(string: "https://dog.ceo/api/breeds/list/all")!
    
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    static func fetchDogs(callback: @escaping (DogBreedsData)->Void){
        let request = URLRequest(url: baseURL)
        let task = session.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let dogBreeds = try decoder.decode(DogBreeds.self, from: data)

                    callback(.success(dogBreeds.message))
                    
                } catch let e {
                    callback(.failure(e))
                }
            } else if let error = error {
                callback(.failure(error))
            }
        }
        task.resume()
    }
}
