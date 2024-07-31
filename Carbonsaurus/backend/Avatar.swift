//
//  Avatar.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 5/15/24.
//

import Foundation

protocol AvatarItem {
    var imageName: String { get }
    var displayName: String { get }
    var dinoPoints: Double { get }
}

enum AvatarColor: String, Codable, AvatarItem {
    case lightGreen
    case green
    case blue
    case orange
    case pink
    
    var imageName: String {
        return self.rawValue + "_dino_happy"
    }
    
    var displayName: String {
        switch self {
        case .blue:
            return "blue"
        case .lightGreen:
            return "light green"
        case .green:
            return "green"
        case .orange:
            return "orange"
        case .pink:
            return "pink"
        }
    }
        
    var dinoPoints: Double {
        switch self {
        case .blue:
            return 0
        case .green:
            return 1000
        case .lightGreen:
            return 1000
        case .orange:
            return 1000
        case .pink:
            return 1000
        }
    }

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

enum AvatarAccessory: String, Codable, AvatarItem {
    case no_accessory
    case banana
    case bowtie
    case flower
    case lollipop
    case spinhat
    case sunglasses
    case tophat
    
    var imageName: String {
        return self.rawValue
    }
    
    var size: Double {
        switch self {
        case .no_accessory:
            return 0
        case .banana:
            return 0.2
        case .bowtie:
            return 0.2
        case .flower:
            return 0.2
        case .lollipop:
            return 0.2
        case .spinhat:
            return 0.3
        case .sunglasses:
            return 0.25
        case .tophat:
            return 0.3
        }
    }
    
    var xOffset: Double {
        switch self {
        case .no_accessory:
            -0.17
        case .banana:
            -0.17
        case .bowtie:
            -0.17
        case .flower:
            -0.25
        case .lollipop:
            -0.25
        case .spinhat:
            -0.17
        case .sunglasses:
            -0.17
        case .tophat:
            -0.17
        }
    }
    
    var yOffset: Double {
        switch self {
        case .no_accessory:
            0.09
        case .banana:
            0.09
        case .bowtie:
            0.09
        case .flower:
            0.13
        case .lollipop:
            0.13
        case .spinhat:
            0.09
        case .sunglasses:
            0.09
        case .tophat:
            0.09
        }
    }
    
    var rotation: Double {
        switch self {
        case .no_accessory:
            0
        case .banana:
            0
        case .bowtie:
            0
        case .flower:
            320
        case .lollipop:
            300
        case .spinhat:
            0
        case .sunglasses:
            0
        case .tophat:
            0
        }
    }

    var displayName: String {
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
    
    var dinoPoints: Double {
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
}

var allAvatarAccessories: [AvatarAccessory] = [.no_accessory, .banana, .bowtie, .flower, .lollipop, .spinhat, .sunglasses, .tophat]

enum AvatarBackground: String, Codable, AvatarItem {
    case no_background
    case mountains
    case beach
    case space
    
    var imageName: String {
        return self.rawValue
    }

    var displayName: String {
        switch self {
        case .no_background:
            return "no background"
        case .mountains:
            return "mountains"
        case .beach:
            return "beach"
        case .space:
            return "space"
        }
    }

    var dinoPoints: Double {
        switch self {
        case .no_background:
            return 0
        case .mountains:
            return 3000
        case .beach:
            return 5000
        case .space:
            return 7000
        }
    }
}

var allAvatarBackgrounds: [AvatarBackground] = [.no_background, .mountains, .beach, .space]

struct Avatar: Codable {
    var color: AvatarColor
    var accessory: AvatarAccessory
    var background: AvatarBackground
    
    init(color: AvatarColor, mood: AvatarMood, accessory: AvatarAccessory, background: AvatarBackground) {
        self.color = color
        self.accessory = accessory
        self.background = background
    }
    
    init() {
        self.color = .blue
        self.accessory = .no_accessory
        self.background = .no_background
    }
    
    func getImageString(mood: AvatarMood) -> String {
        return color.rawValue + "_dino_" + mood.rawValue
    }
    
    func getImageStringOneHigher(mood: AvatarMood) -> String {
        return color.rawValue + "_dino_" + mood.oneHigher().rawValue
    }
}
