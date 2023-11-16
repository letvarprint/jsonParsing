//
//  NetworkManager.swift
//  JSON parsing
//
//  Created by Alexandru Brixencov on 15.11.2023.
//

import Foundation

enum Link {
    case holidaysURL
    case starWarsURL
    case randomFoxURL
    
    var url: URL {
        switch self {
        case .holidaysURL:
            return URL(string: "https://date.nager.at/api/v2/publicholidays/2020/US")!
        case .starWarsURL:
            return URL(string:     "https://swapi.dev/api/planets/3/?format=json")!
        case .randomFoxURL:
            return URL(string:
                        "https://randomfox.ca/floof/")!
        }
    }
}
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingError
    }

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data,NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url)
            else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetchFox(url: URL, completion:@escaping(URL) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let foxImage = try jsonDecoder.decode(FoxImage.self, from: data)
                DispatchQueue.main.async {
                    completion(foxImage.image)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
            print(response)
        } .resume()
    }
    
    func fetchHolidays(url: URL, completition:@escaping([Holiday]) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let holidays = try decoder.decode([Holiday].self, from: data)
                DispatchQueue.main.async {
                    completition(holidays)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
