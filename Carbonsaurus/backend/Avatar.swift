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

struct AccessoryOffset {
    var xOffset: Double
    var yOffset: Double
    var size: Double
    var rotation: Double
}


var accessoryOffsets: [AvatarAccessory : [AvatarColor : AccessoryOffset]] = [
    AvatarAccessory.banana : [
        AvatarColor.lightGreen : AccessoryOffset(xOffset: -0.17, yOffset: 0.09, size: 0.25, rotation: 350),
        AvatarColor.green : AccessoryOffset(xOffset: -0.17, yOffset: 0.01, size: 0.25, rotation: 320),
        AvatarColor.blue : AccessoryOffset(xOffset: -0.17, yOffset: 0.09, size: 0.25, rotation: 350),
        AvatarColor.orange : AccessoryOffset(xOffset: -0.15, yOffset: 0.0, size: 0.25, rotation: 340),
        AvatarColor.pink : AccessoryOffset(xOffset: -0.17, yOffset: 0.13, size: 0.25, rotation: 300),
    ],

    AvatarAccessory.bowtie : [
        AvatarColor.lightGreen : AccessoryOffset(xOffset: -0.15, yOffset: 0.04, size: 0.25, rotation: 350),
        AvatarColor.green : AccessoryOffset(xOffset: -0.12, yOffset: -0.01, size: 0.22, rotation: 350),
        AvatarColor.blue : AccessoryOffset(xOffset: -0.16, yOffset: 0.08, size: 0.20, rotation: 350),
        AvatarColor.orange : AccessoryOffset(xOffset: -0.08, yOffset: -0.01, size: 0.20, rotation: 10),
        AvatarColor.pink : AccessoryOffset(xOffset: -0.16, yOffset: 0.08, size: 0.17, rotation: 330),
    ],

    AvatarAccessory.flower : [
        AvatarColor.lightGreen : AccessoryOffset(xOffset: -0.20, yOffset: 0.1, size: 0.25, rotation: 300),
        AvatarColor.green : AccessoryOffset(xOffset: -0.20, yOffset: 0.05, size: 0.20, rotation: 300),
        AvatarColor.blue : AccessoryOffset(xOffset: -0.20, yOffset: 0.15, size: 0.25, rotation: 300),
        AvatarColor.orange : AccessoryOffset(xOffset: -0.10, yOffset: 0.03, size: 0.20, rotation: 350),
        AvatarColor.pink : AccessoryOffset(xOffset: -0.20, yOffset: 0.15, size: 0.15, rotation: 300),
    ],

    AvatarAccessory.lollipop : [
        AvatarColor.lightGreen : AccessoryOffset(xOffset: -0.20, yOffset: 0.1, size: 0.25, rotation: 300),
        AvatarColor.green : AccessoryOffset(xOffset: -0.17, yOffset: 0.02, size: 0.20, rotation: 300),
        AvatarColor.blue : AccessoryOffset(xOffset: -0.21, yOffset: 0.12, size: 0.25, rotation: 300),
        AvatarColor.orange : AccessoryOffset(xOffset: -0.18, yOffset: 0.02, size: 0.20, rotation: 340),
        AvatarColor.pink : AccessoryOffset(xOffset: -0.16, yOffset: 0.14, size: 0.15, rotation: 290),
    ],

    AvatarAccessory.spinhat : [
        AvatarColor.lightGreen : AccessoryOffset(xOffset: -0.18, yOffset: -0.235, size: 0.25, rotation: 330),
        AvatarColor.green : AccessoryOffset(xOffset: -0.17, yOffset: -0.23, size: 0.4, rotation: 350),
        AvatarColor.blue : AccessoryOffset(xOffset: -0.18, yOffset: -0.15, size: 0.4, rotation: 0),
        AvatarColor.orange : AccessoryOffset(xOffset: -0.01, yOffset: -0.23, size: 0.45, rotation: 20),
        AvatarColor.pink : AccessoryOffset(xOffset: -0.23, yOffset: -0.02, size: 0.2, rotation: 0),
    ],

    AvatarAccessory.sunglasses : [
        AvatarColor.lightGreen : AccessoryOffset(xOffset: -0.14, yOffset: -0.2, size: 0.2, rotation: 350),
        AvatarColor.green : AccessoryOffset(xOffset: -0.18, yOffset: -0.14, size: 0.3, rotation: 350),
        AvatarColor.blue : AccessoryOffset(xOffset: -0.20, yOffset: -0.04, size: 0.3, rotation: 10),
        AvatarColor.orange : AccessoryOffset(xOffset: -0.10, yOffset: -0.15, size: 0.35, rotation: 20),
        AvatarColor.pink : AccessoryOffset(xOffset: -0.24, yOffset: 0.02, size: 0.18, rotation: 20),
    ],

    AvatarAccessory.tophat : [
        AvatarColor.lightGreen : AccessoryOffset(xOffset: -0.20, yOffset: -0.26, size: 0.25, rotation: 330),
        AvatarColor.green : AccessoryOffset(xOffset: -0.08, yOffset: -0.23, size: 0.30, rotation: 20),
        AvatarColor.blue : AccessoryOffset(xOffset: -0.18, yOffset: -0.15, size: 0.30, rotation: 0),
        AvatarColor.orange : AccessoryOffset(xOffset: 0.04, yOffset: -0.23, size: 0.30, rotation: 20),
        AvatarColor.pink : AccessoryOffset(xOffset: -0.23, yOffset: -0.02, size: 0.15, rotation: 0),
    ],
]
