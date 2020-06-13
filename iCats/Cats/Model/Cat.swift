//
//  Cat.swift
//  iCats
//
//  Created by Yuri on 12/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

struct Cat: Codable {
    let id: String
    let title: String
    let images: [Image]?
    
    var url: URL? {
        guard let images = images else { return nil }
        for image in images {
            if !image.link.isEmpty {
                return URL(string: image.link)
            }
        }
        
        return nil
        
    }
}

struct Image: Codable {
    let link: String
}
