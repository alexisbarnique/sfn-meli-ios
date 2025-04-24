//
//  ArticleModelResponse.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 23/04/2025.
//

import Foundation

// MARK: - Article
struct Article: Codable {
    let count: Int
    let next, previous: String
    let results: [ResultArticle]
}

// MARK: - Result
struct ResultArticle: Codable {
    let id: Int
    let title: String
    let authors: [Author]
    let url, imageURL, newsSite, summary: String
    let publishedAt, updatedAt: String
    let featured: Bool
    let launches: [Launch]
    let events: [Event]

    enum CodingKeys: String, CodingKey {
        case id, title, authors, url
        case imageURL = "image_url"
        case newsSite = "news_site"
        case summary
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case featured, launches, events
    }
}

// MARK: - Author
struct Author: Codable {
    let name: String
    let socials: Socials
}

// MARK: - Socials
struct Socials: Codable {
    let x, youtube, instagram, linkedin: String
    let mastodon, bluesky: String
}

// MARK: - Event
struct Event: Codable {
    let eventID: Int
    let provider: String

    enum CodingKeys: String, CodingKey {
        case eventID = "event_id"
        case provider
    }
}

// MARK: - Launch
struct Launch: Codable {
    let launchID, provider: String

    enum CodingKeys: String, CodingKey {
        case launchID = "launch_id"
        case provider
    }
}
