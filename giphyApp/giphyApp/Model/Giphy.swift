//
//  Giphy.swift
//  giphyApp
//
//  Created by Yury Popov on 09/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import Foundation

// MARK: - Giphy
struct Giphy: Decodable {
    let data: [Data]
}

// MARK: - Data
struct Data: Decodable {
    let images: Images
    let title: String
}

// MARK: - Images
struct Images: Decodable {
    let fixedHeightDownsampled: FixedHeight
    enum CodingKeys: String, CodingKey {
        case fixedHeightDownsampled = "fixed_height_downsampled"
    }
}


// MARK: - FixedHeight
struct FixedHeight: Decodable {
    let url: String
}



