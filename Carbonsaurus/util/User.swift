//
//  user.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import Foundation

class User: Identifiable, Codable, ObservableObject {
    var id: UUID
    var username: String
    var diaries: [Diary]
    var avatar: Avatar
    var extraDinoPoints: Double
    var averageDriving, averagePhone, averageAppliances, averageEating, averageShower: Double

    init(username: String, diaries: [Diary], avatar: Avatar, extraDinoPoints: Double, averageDriving: Double, averagePhone: Double, averageAppliances: Double, averageEating: Double, averageShower: Double) {
        self.id = UUID()
        self.username = username
        self.diaries = diaries
        self.avatar = avatar
        self.extraDinoPoints = 0
        self.averageDriving = averageDriving /*?? 1 // 3360*/
        self.averagePhone = averagePhone /*?? 195 // 189*/
        self.averageAppliances = averageAppliances /*??  1 // 2000*/
        self.averageEating = averageEating /*?? 1800 // 4500*/
        self.averageShower = averageShower /*?? 10 // 2000*/
    }

    func getDinoPoints() -> Double {
        var total: Double = 0

        for diary in diaries {
            total += diary.dinoPoints()
        }

        return total + extraDinoPoints
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
        return getDinoPoints() / Double(diaries.count) + extraDinoPoints
    }

    func getDailyAverages() -> [Double] {
        return [averageDriving, averagePhone, averageAppliances, averageEating, averageShower]
    }

    func getDinoStatus() -> AvatarMood {
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

    func getDinoStatusDescription() -> String {
        switch getDinoStatus() {
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
}
