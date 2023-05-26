//
//  iTunesAPI.swift
//  memory-tunes
//
//  Created by Snow Lukin on 26.05.2023.
//

import Foundation

final class iTunesAPI {
    static func searchFor(category: String, completion: @escaping ([String]) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(category)&entity=song"
        let urlRequest: URLRequest = URLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            // React on errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("Error: Data is nil")
                completion([])
                return
            }
            
            do {
                let strings = try iTunesAPI.parseResponseToImageUrls(data)
                DispatchQueue.main.async {
                    completion(strings)
                }
            } catch {
                print("Error: Could not fetch/parse image urls from the server - \(error.localizedDescription)")
                completion([])
            }
        }
        
        task.resume()
    }
    
    static func parseResponseToImageUrls(_ responseData: Data) throws -> [String] {
        guard let dictionary = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject],
              let array = dictionary["results"] as? [[String: AnyObject]] else {
            throw NSError(domain: "iTunesAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON format"])
        }
        
        let strings = array.compactMap { (dictionary) -> String? in
            return dictionary["artworkUrl100"] as? String
        }
        
        return strings
    }
}
