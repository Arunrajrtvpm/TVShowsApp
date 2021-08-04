//
//  SeasonModel.swift
//  TVShow
//
//  Created by Arunraj on 04/08/21.
//

import Foundation

struct SeasonModel: Codable {
    let id: Int
    let url: String
    let number: Int
    let name: String
    let episodeOrder: Int
    let premiereDate, endDate: String
    let network: Network?
    let image: Image
    let summary: String
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id, url, number, name, episodeOrder, premiereDate, endDate, network, image, summary
        case links = "_links"
    }
}

