//
//  NewsModel.swift
//  News
//
//  Created by Naira Bassam on 26/08/2021.
//

import Foundation

struct NewsModel: Decodable {
    let articles: [Articles]
}

struct Articles: Decodable {
    let title: String
    let description: String?
    let urlToImage: String?
    let source: Source
    let url: String?
}
struct Source: Codable {
    let name: String
}

