//
//  NewsViewModel.swift
//  News
//
//  Created by Naira Bassam on 26/08/2021.
//

import Foundation

class NewsViewModel {
    
    let sourceName: String
    let title: String
    let imageURL: URL? 
    var imageData: Data? = nil
    
    init(sourceName: String,
         title: String,
         imageURL: URL?) {
        self.sourceName = sourceName
        self.title = title
        self.imageURL = imageURL
    }
}

