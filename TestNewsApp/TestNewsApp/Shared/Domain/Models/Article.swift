//
//  Article.swift
//  TestNewsApp
//
//  Created by Natalia  Stele on 01/06/2021.
//

import Foundation

// MARK: - Article
struct Article: Codable, Identifiable, Hashable {
  let id = UUID()
  
  let rights: String?
  let author: String?
  let isOpinion: Bool?
  let score: Float?
  let sourceID: String?
  let authors: [String]?
  let cleanURL: String?
  let link: String?
  let publishedDatePrecision: String?
  let rank: Int?
  let language: String?
  let summary: String?
  let publishedDate: String?
  let media: String?
  let title: String?
  let country: String?
  let topic: String?
  let twitterAccount: String?
  
  enum CodingKeys: String, CodingKey {
    
    case rights, author
    case isOpinion = "is_opinion"
    case score = "_score"
    case sourceID = "_id"
    case authors
    case cleanURL = "clean_url"
    case link
    case publishedDatePrecision = "published_date_precision"
    case rank
    case language, summary
    case publishedDate = "published_date"
    case media, title, country, topic
    case twitterAccount = "twitter_account"
  }
}



