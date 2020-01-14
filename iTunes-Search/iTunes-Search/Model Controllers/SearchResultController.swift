//
//  SearchResultController.swift
//  iTunes-Search
//
//  Created by Alexander Supe on 1/14/20.
//  Copyright © 2020 Alexander Supe. All rights reserved.
//

import Foundation

class SearchResultController {
    private var baseURL = URLComponents(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void){
        
        baseURL.queryItems = [  URLQueryItem(name: "country", value: "us"),
                                URLQueryItem(name: "entity", value: resultType.rawValue),
                                URLQueryItem(name: "term", value: searchTerm)]
        guard let finalURL = baseURL.url else { return }
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error)
                return
            }
            guard let data = data else {
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.searchResults = try decoder.decode(SearchResults.self, from: data).results
                completion(nil)
            } catch {
                completion(error)
                return
            }
        }.resume()
    }
}
