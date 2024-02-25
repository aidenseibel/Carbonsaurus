//
//  user.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import Foundation
import SwiftUI

enum avatar: Codable{
    case light_green
    case green
    case blue
    case orange
    case pink
}

enum avatarStatus: Codable{
    case great
    case happy
    case neutral
    case worried
    case sad
}

class user: Identifiable, Codable, ObservableObject{
    var id: UUID
    var username: String
    var diaries: [diary]
    var avatar: avatar
    var avatarStatus: avatarStatus
    var extraDinoPoints: Int
    var average_driving, average_phone, average_appliances, average_eating, average_shower: Int
        
    init(username: String, diaries: [diary], avatar: avatar, avatarStatus: avatarStatus,extraDinoPoints: Int, average_driving: Int, average_phone: Int, average_appliances: Int, average_eating: Int, average_shower: Int) {
        self.id = UUID()
        self.username = username
        self.diaries = diaries
        self.avatar = avatar
        self.avatarStatus = avatarStatus
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
    
    func getDinoStatus() -> avatarStatus{
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
    
    func dinoStatusToString() -> String{
        switch getDinoStatus(){
        case .sad:
            return "sad"
        case .worried:
            return "worried"
        case .neutral:
            return "neutral"
        case .happy:
            return "happy"
        case .great:
            return "great"
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
    
    func getAvatar() -> String{
        switch avatar {
        case .light_green:
            return "light_green_dino"
        case .green:
            return "green_dino"
        case .blue:
            return "blue_dino"
        case .orange:
            return "orange_dino"
        case .pink:
            return "pink_dino"
        }
    }
    
    func getDinoImageString() -> String {
        switch avatar {
        case .light_green:
            switch getDinoStatus() {
            case .great:
                return "light_green_dino_great"
            case .happy:
                return "light_green_dino_happy"
            case .neutral:
                return "light_green_dino_neutral"
            case .worried:
                return "light_green_dino_worried"
            case .sad:
                return "light_green_dino_sad"
            }
        case .green:
            switch getDinoStatus() {
            case .great:
                return "green_dino_great"
            case .happy:
                return "green_dino_happy"
            case .neutral:
                return "green_dino_neutral"
            case .worried:
                return "green_dino_worried"
            case .sad:
                return "green_dino_sad"
            }
        case .blue:
            switch getDinoStatus() {
            case .great:
                return "blue_dino_great"
            case .happy:
                return "blue_dino_happy"
            case .neutral:
                return "blue_dino_neutral"
            case .worried:
                return "blue_dino_worried"
            case .sad:
                return "blue_dino_sad"
            }
        case .orange:
            switch getDinoStatus() {
            case .great:
                return "orange_dino_great"
            case .happy:
                return "orange_dino_happy"
            case .neutral:
                return "orange_dino_neutral"
            case .worried:
                return "orange_dino_worried"
            case .sad:
                return "orange_dino_sad"
            }
        case .pink:
            switch getDinoStatus() {
            case .great:
                return "pink_dino_great"
            case .happy:
                return "pink_dino_happy"
            case .neutral:
                return "pink_dino_neutral"
            case .worried:
                return "pink_dino_worried"
            case .sad:
                return "pink_dino_sad"
            }
        }
    }
    
    func getHigherDinoImageString() -> String{
        switch avatar {
        case .light_green:
            switch getDinoStatus() {
            case .great:
                return "light_green_dino_happy"
            case .happy:
                return "light_green_dino_great"
            case .neutral:
                return "light_green_dino_happy"
            case .worried:
                return "light_green_dino_neutral"
            case .sad:
                return "light_green_dino_worried"
            }
        case .green:
            switch getDinoStatus() {
            case .great:
                return "green_dino_happy"
            case .happy:
                return "green_dino_great"
            case .neutral:
                return "green_dino_happy"
            case .worried:
                return "green_dino_neutral"
            case .sad:
                return "green_dino_worried"
            }
        case .blue:
            switch getDinoStatus() {
            case .great:
                return "blue_dino_happy"
            case .happy:
                return "blue_dino_great"
            case .neutral:
                return "blue_dino_happy"
            case .worried:
                return "blue_dino_neutral"
            case .sad:
                return "blue_dino_worried"
            }
        case .orange:
            switch getDinoStatus() {
            case .great:
                return "orange_dino_happy"
            case .happy:
                return "orange_dino_great"
            case .neutral:
                return "orange_dino_happy"
            case .worried:
                return "orange_dino_neutral"
            case .sad:
                return "orange_dino_worried"
            }
        case .pink:
            switch getDinoStatus() {
            case .great:
                return "pink_dino_happy"
            case .happy:
                return "pink_dino_great"
            case .neutral:
                return "pink_dino_happy"
            case .worried:
                return "pink_dino_neutral"
            case .sad:
                return "pink_dino_worried"
            }
        }

    }
}
