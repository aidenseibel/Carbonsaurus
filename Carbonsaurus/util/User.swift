//
//  user.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import Foundation
//import SwiftUI

class User: Identifiable, Codable, ObservableObject{
    var id: UUID
    var username: String
    var diaries: [Diary]
    var avatar: Avatar
    var extraDinoPoints: Int
    var average_driving, average_phone, average_appliances, average_eating, average_shower: Int
        
    init(username: String, diaries: [Diary], avatar: Avatar, extraDinoPoints: Int, average_driving: Int, average_phone: Int, average_appliances: Int, average_eating: Int, average_shower: Int) {
        self.id = UUID()
        self.username = username
        self.diaries = diaries
        self.avatar = avatar
        self.extraDinoPoints = 0
        self.average_driving = average_driving /*?? 1 // 3360*/
        self.average_phone = average_phone /*?? 195 // 189*/
        self.average_appliances = average_appliances /*??  1 // 2000*/
        self.average_eating = average_eating /*?? 1800 // 4500*/
        self.average_shower = average_shower /*?? 10 // 2000*/
    }
        
    func getDinoPoints() -> Int{
        var total = 0
        
        for diary in diaries {
            total = total + diary.dinoPoints()
        }
        
        return total + extraDinoPoints
    }
    
    func getAverageDinoPointsThisWeek() -> Int{
        var total = 0
        var count = 0
        
        for diary in diaries {
            if isLessThanAWeekAgo(date: diary.date){
                total = total + diary.dinoPoints()
                count = count + 1
            }
        }
        
        return total / count
    }
    
    func getCarbonFootprintThisWeek() -> Int{
        var total = 0
        
        for diary in diaries {
            if isLessThanAWeekAgo(date: diary.date){
                total = total + diary.calculateCarbonFootprint(averages: getDailyAverages())
            }
        }
        
        return total
    }
    

    func getAverageDinoPoints() -> Int{
        if diaries.isEmpty{
            return 0
        }
        return getDinoPoints() / diaries.count + extraDinoPoints
    }
    
    func getCarbonRanking() -> Int {
        return Int(3000 - Double(getAverageDinoPointsThisWeek()) * 1.25)
    }
    
    func getDailyAverages() -> [Int]{
        return [average_driving, average_phone, average_appliances, average_eating, average_shower]
    }
    
    func getDinoStatus() -> avatar_mood{
        switch getAverageDinoPointsThisWeek(){
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
        
    func getDinoStatusDescription() -> String{
        switch getDinoStatus(){
        case .sad:
            return "oh no! it's been a hard week. you got this! check out your stats:"
        case .worried:
            return "stick in there! remember your goals, you got this. check out your stats:"
        case .neutral:
            return "you're trying so hard! don't worry, we know it's difficult. check out your stats:"
        case .happy:
            return "congrats! you’ve done such a good job lately. check out your stats:"
        case .great:
            return "oh yeah! now that's what i'm talking about. keep it up and check out your stats:"
        }
    }
}
