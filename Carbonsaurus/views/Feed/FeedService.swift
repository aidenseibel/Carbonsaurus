//
//  FeedService.swift
//  Carbonsaurus
//
//  Created by Yash Shah on 2/24/24.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct Article: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id = UUID()

    let source: Source
    let title: String
    let url: String
    let publishedAt: Date
    
    let author: String?
    let description: String?
    let urlToImage: String?
    
    
    enum CodingKeys: String, CodingKey {
        case source
        case title
        case url
        case publishedAt
        case author
        case description
        case urlToImage
    }
    
    var authorText: String {
        author ?? ""
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var captionText: String {
        "\(source.name) ‧ \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
}

extension Article: Codable {}
extension Article: Equatable {}
extension Article: Identifiable {}

struct Source {
    let name: String
}

extension Source: Codable {}
extension Source: Equatable {}

class FeedService {
    static let shared = FeedService()
    private let apiKey = "f1f3468c3181496c84dcbec0af0a1ee8"
    let numberOfDaysToRequest = 10;
    
    func fetchTopStories(completion: @escaping ([Article]?) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=climate change OR global warming OR emission OR environment&from=\(getFormattedURLDate(date: Calendar.current.date(byAdding: .day, value: -numberOfDaysToRequest, to: Date())!))&to=\(getFormattedURLDate(date: Date()))&pageSize=10&excludeDomains=yahoo.com&sortBy=popularity&apiKey=\(apiKey)") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(FeedResponse.self, from: data)
                let articles = response.articles
                completion(articles)
            } catch let error {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

struct FeedResponse: Decodable {
    let articles: [Article]
}
