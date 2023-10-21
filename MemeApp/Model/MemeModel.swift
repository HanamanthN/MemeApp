//
//  MemeModel.swift
//  MemeApp
//
//  Created by Hanamanth Nagonde on 18/10/23.
//

import Foundation

struct MemeModle: Codable {
    let success: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let memes: [Meme]
}

// MARK: - Meme
struct Meme: Codable, Hashable {
    let id, name: String
    let url: String
    let width, height, boxCount, captions: Int

    enum CodingKeys: String, CodingKey {
        case id, name, url, width, height
        case boxCount = "box_count"
        case captions
    }
}
