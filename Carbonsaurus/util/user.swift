//
//  user.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import Foundation
import SwiftUI

enum avatar: Codable{
    case red
    case blue
    case purple
    case green
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
    
    init(username: String, diaries: [diary], avatar: avatar, avatarStatus: avatarStatus) {
        self.id = UUID()
        self.username = username
        self.diaries = diaries
        self.avatar = avatar
        self.avatarStatus = avatarStatus
    }
    
    func getDinoPoints() -> Int{
        var total = 0
        
        for diary in diaries {
            total = total + diary.dinoPoints()
        }
        
        return total
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
    
    func getAverageDinoPoints() -> Int{
        if diaries.isEmpty{
            return 0
        }
        return getDinoPoints() / diaries.count
    }
    
    func getCarbonRanking() -> Int {
        return Int(3000 - Double(getAverageDinoPointsThisWeek()) * 1.25)
    }
    
    func getDinoStatus() -> avatarStatus{
        switch getAverageDinoPointsThisWeek(){
        case 0..<900:
            return .sad
        case 900..<1300:
            return .worried
        case 1300..<1700:
            return .neutral
        case 1700..<2200:
            return .happy
        case let value where value>2200:
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
            return "oh no! it's been a hard week. you got this! check out your stats"
        case .worried:
            return "stick in there! remember your goals, you got this. check out your stats"
        case .neutral:
            return "you're trying so hard! don't worry, we know it's difficult. check out your stats"
        case .happy:
            return "congrats! you’ve done such a good job lately. check out your stats!"
        case .great:
            return "oh yeah! now that's what i'm talking about. keep it up and check out your stats"
        }

    }
}