//
//  DetailsViewModel.swift
//  News
//
//  Created by Naira Bassam on 26/08/2021.
//

import Foundation

class DetailsViewModel {
    
    let sourceName: String
    let title: String
    let imageURL: URL?
    var imageData: Data? = nil
    let description: String?
    let url: String?
    
    init(sourceName: String,
         title: String,
         imageURL: URL?,
         description: String?,
         url: String?) {
        self.sourceName = sourceName
        self.title = title
        self.imageURL = imageURL
        self.description = description
        self.url = url
    }
}
