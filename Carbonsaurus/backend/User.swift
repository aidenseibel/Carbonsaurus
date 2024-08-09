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
    var dailyQuizzes: [DailyQuiz] = []
    
    var avatar: Avatar = Avatar()
    var ownedAvatarColors: [AvatarColor] = [.blue]
    var ownedAvatarAccessories: [AvatarAccessory] = [.no_accessory]
    var ownedAvatarBackgrounds: [AvatarBackground] = [.no_background]
    
    var dinoPointsBalance: Double = 0
    var averageDriving, averageEnergy, averageEating, averageWater: Double
    
    init() {
        username = ""
        averageDriving = 3.0
        averageEnergy = 3.0
        averageEating = 3.0
        averageWater = 3.0
    }

    init(username: String, averageDriving: Double, averagePhone: Double, averageEnergy: Double, averageEating: Double, averageWater: Double) {
        self.username = username
        self.averageDriving = averageDriving            /*?? 1 // 3360*/
        self.averageEnergy = averageEnergy      /*??  1 // 2000*/
        self.averageEating = averageEating              /*?? 1800 // 4500*/
        self.averageWater = averageWater              /*?? 10 // 2000*/
    }
    
    func addDiary(diary: Diary) {
        diaries.append(diary)
        dinoPointsBalance += diary.dinoPoints()
    }

    func addDailyQuiz(dailyQuiz: DailyQuiz) {
        dailyQuizzes.append(dailyQuiz)
        dinoPointsBalance += 50
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
    
    func getDailyQuizzesThisWeek() -> [DailyQuiz] {
        var dailyQuizzesThisWeek: [DailyQuiz] = []

        for dailyQuiz in dailyQuizzes {
            if isLessThanAWeekAgo(date: dailyQuiz.date) {
                dailyQuizzesThisWeek.append(dailyQuiz)
            }
        }

        return dailyQuizzesThisWeek
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
        
        for dailyQuiz in getDailyQuizzesThisWeek() {
            total += 500
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
        return [averageDriving, averageEnergy, averageEating, averageWater]
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
            return "are you even trying?"
        case .worried:
            return "you're this close to killing the planet."
        case .neutral:
            return "hang in there, chief."
        case .happy:
            return "mic drop."
        case .great:
            return "clutch af."
        }
    }
    
    func getAvatarImage() -> String {
        return avatar.getImageString(mood: getDinoMood())
    }

    func getAvatarImageOneHigher() -> String {
        return avatar.getImageStringOneHigher(mood: getDinoMood())
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
