//
//  user.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import Foundation

enum avatar{
    case red
    case blue
    case purple
    case green
}

struct user{
    var id = UUID()
    var username: String
    var dinoPoints: Int
    var diaries: [diary]
    var avatar: avatar
}
