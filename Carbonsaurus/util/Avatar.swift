//
//  Avatar.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 5/15/24.
//

import Foundation

enum avatar_color: String, Codable{
    case light_green
    case green
    case blue
    case orange
    case pink
}

var all_avatar_colors: [avatar_color] = [.blue, .green, .light_green, .orange, .pink]

enum avatar_mood: String, Codable{
    case great
    case happy
    case neutral
    case worried
    case sad
    
    func oneHigher() -> avatar_mood{
        switch self{
        case .great: return .happy
        case .happy: return .great
        case .neutral: return .happy
        case .worried: return .neutral
        case .sad: return .worried
        }
    }
}

enum avatar_accessory: String, Codable{
    case banana
    case bowtie
    case flower
    case lollipop
    case spinhat
    case sunglasses
    case tophat
    
    var dinoPoints: Int {
        switch self {
            case .banana:
                return 1000
            case .bowtie:
                return 1000
            case .flower:
                return 2000
            case .lollipop:
                return 2000
            case .spinhat:
                return 5000
            case .sunglasses:
                return 5000
            case .tophat:
                return 5000
        }
    }

    var name: String{
        switch self {
            case .banana:
                return "banana"
            case .bowtie:
                return "bowtie"
            case .flower:
                return "flower"
            case .lollipop:
                return "lollipop"
            case .spinhat:
                return "spin hat"
            case .sunglasses:
                return "sunglasses"
            case .tophat:
                return "top hat"
        }
    }
    
    var imageString: String{
        switch self {
            case .banana:
                return "banana"
            case .bowtie:
                return "bowtie"
            case .flower:
                return "flower_acc" // here is different
            case .lollipop:
                return "lollipop"
            case .spinhat:
                return "spinhat"
            case .sunglasses:
                return "sunglasses"
            case .tophat:
                return "tophat"
        }
    }
}


struct Avatar: Codable{
    var color: avatar_color
    var mood: avatar_mood
    var accessory: avatar_accessory?
    
    func getImageString() -> String{
        return color.rawValue + "_dino_" + mood.rawValue
    }
    
    func getHigherImageString() -> String{
        return color.rawValue + "_dino_" + mood.oneHigher().rawValue
    }
}
