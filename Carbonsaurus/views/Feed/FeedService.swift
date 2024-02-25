//
//  FeedService.swift
//  Carbonsaurus
//
//  Created by Yash Shah on 2/24/24.
//

import Foundation

struct Article: Decodable, Hashable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.url == rhs.url
    }
    var id = UUID()
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    let section: String
    let subsection: String?
    let title: String
    let abstract: String
    let url: String?
    let uri: String
    let byline: String?
    let itemType: String
    let updatedDate: Date
    let createdDate: Date
    let publishedDate: Date
    let materialTypeFacet: String?
    let kicker: String?
    let desFacet: [String]
    let orgFacet: [String]
    let perFacet: [String]
    let geoFacet: [String]
    let multimedia: [Multimedia]
    let shortUrl: String
    
    enum CodingKeys: String, CodingKey {
        case section
        case subsection
        case title
        case abstract
        case url
        case uri
        case byline
        case itemType = "item_type"
        case updatedDate = "updated_date"
        case createdDate = "created_date"
        case publishedDate = "published_date"
        case materialTypeFacet = "material_type_facet"
        case kicker
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case multimedia
        case shortUrl = "short_url"
    }
}

struct Multimedia: Decodable {
    let url: String
    let format: String
    let height: Int
    let width: Int
    let type: String
    let subtype: String
    let caption: String
    let copyright: String
}

class FeedService {
    static let shared = FeedService()
    private let apiKey = "s3T85WyaHvrJG5Q6n0elFP6bBIY61NgM"
    
    func fetchTopStories(completion: @escaping ([Article]?) -> Void) {
        guard let url = URL(string: "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=\(apiKey)") else {
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
//                print("Fetched articles: \(response.results)")
                completion(response.results)
            } catch let error {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

struct FeedResponse: Decodable {
    let results: [Article]
}
