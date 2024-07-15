//
//  Avatar.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 5/15/24.
//

import Foundation

enum AvatarColor: String, Codable {
    case lightGreen
    case green
    case blue
    case orange
    case pink
}

var allAvatarColors: [AvatarColor] = [.blue, .green, .lightGreen, .orange, .pink]

enum AvatarMood: String, Codable {
    case great
    case happy
    case neutral
    case worried
    case sad

    func oneHigher() -> AvatarMood {
        switch self {
        case .great: return .happy
        case .happy: return .great
        case .neutral: return .happy
        case .worried: return .neutral
        case .sad: return .worried
        }
    }
}

enum AvatarAccessory: String, Codable {
    case no_accessory
    case banana
    case bowtie
    case flower
    case lollipop
    case spinhat
    case sunglasses
    case tophat

    var dinoPoints: Int {
        switch self {
        case .no_accessory:
            return 0
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

    var name: String {
        switch self {
        case .no_accessory:
            return "no accessory"
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
}

var allAvatarAccessories: [AvatarAccessory] = [.no_accessory, .banana, .bowtie, .flower, .lollipop, .spinhat, .sunglasses, .tophat]

enum AvatarBackground: String, Codable {
    case no_background
    case mountains
    case beach
    case space

    var dinoPoints: Int {
        switch self {
        case .no_background:
            return 0
        case .mountains:
            return 1000
        case .beach:
            return 3000
        case .space:
            return 5000
        }
    }

    var name: String {
        return self.rawValue
    }
}

var allAvatarBackgrounds: [AvatarBackground] = [.no_background, .mountains, .beach, .space]

struct Avatar: Codable {
    var color: AvatarColor
    var mood: AvatarMood
    var accessory: AvatarAccessory
    var background: AvatarBackground

    func getImageString() -> String {
        return color.rawValue + "_dino_" + mood.rawValue
    }

    func getHigherImageString() -> String {
        return color.rawValue + "_dino_" + mood.oneHigher().rawValue
    }
}
