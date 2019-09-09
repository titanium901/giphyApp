//
//  GifRequest.swift
//  giphyApp
//
//  Created by Yury Popov on 09/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import Foundation

enum GiphyError: Error {
    case noDataAvalible
    case canNotProcessData
}

private let baseURL = "https://api.giphy.com/v1/gifs/trending?api_key=DRw5G3TjdUtpmcEJdJ5gnH6JTqe3G6o4&limit=50&rating=G"

struct GifReguest {
    let resourseURL: URL
    let API_KEY = "DRw5G3TjdUtpmcEJdJ5gnH6JTqe3G6o4"
    
    
    init(searchURL: Bool, word: String?, limit: String, endpoint: String) {
        var resourseString = ""
        if searchURL {
            resourseString = "https://api.giphy.com/v1/gifs/search?api_key=\(API_KEY)&q=\(word!)&limit=\(limit)&offset=0&rating=G&lang=en"
        } else {
            resourseString = "https://api.giphy.com/v1/gifs/\(endpoint)?api_key=\(API_KEY)&limit=\(limit)&rating=G"
        }
        guard let resourseURL = URL(string: resourseString) else {
            self.resourseURL = URL(string: baseURL)!
            return
        }
        self.resourseURL = resourseURL
        
    }
    
    func getGifs(completion: @escaping(Result<[Data], GiphyError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourseURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvalible))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let gifsResponse = try decoder.decode(Giphy.self, from: jsonData)
                let gifDetails = gifsResponse.data
                completion(.success(gifDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
