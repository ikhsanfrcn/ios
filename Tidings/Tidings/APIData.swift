//
//  APIData.swift
//  Tidings
//
//  Created by Ikhsan Fathurrachman on 26/09/22.
//

import Foundation

final class APIData {
    static let shared = APIData()
    struct Constants {
        static let topHeadlinesURL = URL(string:
        "https://newsapi.org/v2/top-headlines?country=id&apiKey=cb946ee80ba14865861a61f73b926ff6")
    }
    
    private init () {}
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
        return
    }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in if let error = error {
            completion(.failure(error))
        }
            else if let data = data {
                do {let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {completion(.failure(error))}
            }
        }
        task.resume()
    }
}

//Models

struct APIResponse:Codable{
    let articles: [Article]
}
struct Source: Codable{
    let name: String
}
struct Article: Codable{
    let source: Source, title: String, description: String?, url: String?, urlToImage: String?, publishedAt: String
}

