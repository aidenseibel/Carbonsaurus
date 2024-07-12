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
    var extraDinoPoints: Int
    var averageDriving, averagePhone, averageAppliances, averageEating, averageShower: Int

    init(username: String, diaries: [Diary], avatar: Avatar, extraDinoPoints: Int, averageDriving: Int, averagePhone: Int, averageAppliances: Int, averageEating: Int, averageShower: Int) {
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

    func getDinoPoints() -> Int {
        var total = 0

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

    func getAverageDinoPointsThisWeek() -> Int {
        var total = 0
        var count = 0

        for diary in getDiariesThisWeek() {
            total += diary.dinoPoints()
            count += 1
        }

        if count == 0 { return 0 }
        return total / count
    }

    func getDinoPointsThisWeek() -> Int {
        var total = 0

        for diary in getDiariesThisWeek() {
            total += diary.dinoPoints()
        }

        return total
    }

    func getCarbonFootprintThisWeek() -> Int {
        var total = 0

        for diary in getDiariesThisWeek() {
            total += diary.calculateCarbonFootprint(averages: getDailyAverages())
        }

        return total
    }

    func getAverageDinoPoints() -> Int {
        if diaries.isEmpty {
            return 0
        }
        return getDinoPoints() / diaries.count + extraDinoPoints
    }

    func getDailyAverages() -> [Int] {
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
