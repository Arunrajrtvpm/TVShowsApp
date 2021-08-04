//
//  ShowListModel.swift
//  TVShow
//
//  Created by Arunraj on 04/08/21.
//

import Foundation


struct ShowModel: Codable {
    let id: Int
    let url: String
    let name, type, language: String
    let genres: [String]
    let status: String
    let runtime, averageRuntime: Int?
    let premiered: String
    let officialSite: String?
    let schedule: Schedule
    let rating: Rating?
    let weight: Int
    let network: Network?
    let externals: Externals?
    let image: Image
    let summary: String
    let updated: Int
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, officialSite, schedule, rating, weight, network, externals, image, summary, updated
        case links = "_links"
    }
}

// MARK: - Externals
struct Externals: Codable {
    let tvrage, thetvdb: Int?
    let imdb: String?
}

// MARK: - Image
struct Image: Codable {
    let medium, original: String
}

// MARK: - Links
struct Links: Codable {
    let linksSelf, previousepisode: Previousepisode

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode
    }
}

// MARK: - Previousepisode
struct Previousepisode: Codable {
    let href: String
}

// MARK: - Network
struct Network: Codable {
    let id: Int
    let name: String
    let country: Country
}

// MARK: - Country
struct Country: Codable {
    let name, code, timezone: String
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double?
}

// MARK: - Schedule
struct Schedule: Codable {
    let time: String
    let days: [String]
}



