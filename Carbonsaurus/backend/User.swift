//
//  user.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import Foundation

class User: Identifiable, Codable, ObservableObject {
    var id: UUID = UUID()
    var username: String
    var diaries: [Diary] = []
    
    var avatar: Avatar = Avatar()
    var ownedAvatarColors: [AvatarColor] = [.blue]
    var ownedAvatarAccessories: [AvatarAccessory] = [.no_accessory]
    var ownedAvatarBackgrounds: [AvatarBackground] = [.no_background]
    
    var dinoPointsBalance: Double = 0
    var averageDriving, averageEnergy, averageEating, averageShower: Double
    
    init() {
        username = ""
        averageDriving = 3.0
        averageEnergy = 3.0
        averageEating = 3.0
        averageShower = 3.0
    }

    init(username: String, averageDriving: Double, averagePhone: Double, averageEnergy: Double, averageEating: Double, averageShower: Double) {
        self.username = username
        self.averageDriving = averageDriving            /*?? 1 // 3360*/
        self.averageEnergy = averageEnergy      /*??  1 // 2000*/
        self.averageEating = averageEating              /*?? 1800 // 4500*/
        self.averageShower = averageShower              /*?? 10 // 2000*/
    }
    
    func addDiary(diary: Diary) {
        diaries.append(diary)
        dinoPointsBalance += diary.dinoPoints()
    }

    func getDinoPoints() -> Double {
        var total: Double = 0

        for diary in diaries {
            total += diary.dinoPoints()
        }

        return total
    }

    func getDiariesThisWeek() -> [Diary] {
        var diariesThisWeek: [Diary] = []

        for diary in diaries {
            if isLessThanAWeekAgo(date: diary.date) {
                diariesThisWeek.append(diary)
            }
        }

        return diariesThisWeek
    }

    func getAverageDinoPointsThisWeek() -> Double {
        var total: Double = 0
        var count: Double = 0

        for diary in getDiariesThisWeek() {
            total += diary.dinoPoints()
            count += 1.0
        }

        if count == 0 { return 0 }
        return total / count
    }

    func getDinoPointsThisWeek() -> Double {
        var total: Double = 0

        for diary in getDiariesThisWeek() {
            total += diary.dinoPoints()
        }

        return total
    }

    func getCarbonFootprintThisWeek() -> Double {
        var total: Double = 0

        for diary in getDiariesThisWeek() {
            total += diary.calculateCarbonFootprint(averages: getDailyAverages())
        }

        return total
    }

    func getAverageDinoPoints() -> Double {
        if diaries.isEmpty {
            return 0
        }
        return getDinoPoints() / Double(diaries.count) + dinoPointsBalance
    }

    func getDailyAverages() -> [Double] {
        return [averageDriving, averageEnergy, averageEating, averageShower]
    }

    func getDinoMood() -> AvatarMood {
        switch getAverageDinoPointsThisWeek() {
        case 0..<1200:
            return .sad
        case 1200..<1400:
            return .worried
        case 1400..<1600:
            return .neutral
        case 1600..<1800:
            return .happy
        case let value where value>1800:
            return .great
        default:
            return .neutral
        }
    }

    func getDinoMoodDescription() -> String {
        switch getDinoMood() {
        case .sad:
            return "it's been a hard week."
        case .worried:
            return "you're this close to killing the planet."
        case .neutral:
            return "don't worry, we know it's difficult."
        case .happy:
            return "congrats on being clutch this week."
        case .great:
            return "now that's what i'm talking about."
        }
    }
    
    func getAvatarImage() -> String {
        return avatar.color.rawValue + "_dino_" + getDinoMood().rawValue
    }

    func getAvatarImageOneHigher() -> String {
        return avatar.color.rawValue + "_dino_" + getDinoMood().oneHigher().rawValue
    }
    
    func buyShopItem(shopItem: AvatarItem) -> Bool {
        if dinoPointsBalance >= shopItem.dinoPoints {
            dinoPointsBalance -= shopItem.dinoPoints
            
            switch shopItem{
            case is AvatarColor:
                ownedAvatarColors.append(shopItem as! AvatarColor)
            case is AvatarAccessory:
                ownedAvatarAccessories.append(shopItem as! AvatarAccessory)
            case is AvatarBackground:
                ownedAvatarBackgrounds.append(shopItem as! AvatarBackground)
            default:
                return false
            }

            return true
        }
        
        return false
    }
}
