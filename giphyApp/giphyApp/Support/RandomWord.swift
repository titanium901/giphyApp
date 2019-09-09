//
//  RandomWord.swift
//  giphyApp
//
//  Created by Yury Popov on 09/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import Foundation

class RandomWord {
    
    static let share = RandomWord()
    
    private let words = ["marvel", "apple", "ufc", "wwe", "music", "USOpen", "summer", "winter", "wow", "mmo", "anime", "soccer", "film", "therock", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "google", "ios", "development", "air", "area51", "nike", "russia", "usa", "china"]
    
    func random() -> String {
        return words.randomElement()!
    }
}
