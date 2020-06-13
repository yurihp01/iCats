//
//  ImgurResponse.swift
//  iCats
//
//  Created by Yuri on 12/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

struct ImgurResponse<T: Codable>: Codable {
    let data: [T]
}
