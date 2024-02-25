//
//  diary.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import Foundation

struct diary: Identifiable, Codable, Hashable{
    var id: UUID
    var date: Date
    var driving, phone, appliances, eat, shower: Int
    
    init(date: Date, driving: Int, phone: Int, appliances: Int, eat: Int, shower: Int) {
        self.id = UUID()
        self.date = date
        self.driving = driving
        self.phone = phone
        self.appliances = appliances
        self.eat = eat
        self.shower = shower
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func total() -> Int{
        return driving + phone + appliances + eat + shower
    }
    
    func dinoPoints() -> Int{
        return 3000 - total() * 100
    }

}

var exampleDiaries: [diary] = [
    diary(date: Date(timeIntervalSinceNow: -86400), driving: 3, phone: 2, appliances: 4, eat: 3, shower: 2),
    diary(date: Date(timeIntervalSinceNow: -172800), driving: 4, phone: 2, appliances: 1, eat: 3, shower: 3),
    diary(date: Date(timeIntervalSinceNow: -259200), driving: 2, phone: 4, appliances: 1, eat: 3, shower: 3),
    diary(date: Date(timeIntervalSinceNow: -345600), driving: 3, phone: 4, appliances: 1, eat: 3, shower: 2),
    diary(date: Date(timeIntervalSinceNow: -432000), driving: 5, phone: 5, appliances: 2, eat: 3, shower: 4),
]
