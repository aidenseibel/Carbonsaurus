//
//  diary.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import Foundation

struct Diary: Identifiable, Codable, Hashable {
    var id: UUID
    var date: Date
    var driving, phone, appliances, eat, shower: Double

    init(date: Date, driving: Double, phone: Double, appliances: Double, eat: Double, shower: Double) {
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

    func total() -> Double {
        return driving + phone + appliances + eat + shower
    }

    func dinoPoints() -> Double {
        return 3000.0 - total() * 100.0
    }

    func getImage(userAvatar: String) -> String {
        switch dinoPoints() {
        case 0..<900.0:
            return userAvatar + "_sad"
        case 900..<1300.0:
            return userAvatar + "_worried"
        case 1300..<1700.0:
            return userAvatar + "_neutral"
        case 1700..<2200.0:
            return userAvatar + "_happy"
        default:
            return userAvatar + "_great"
        }
    }

    func calculateCarbonFootprint(averages: [Double]) -> Double {
        var carbonFootprint: Double = 0

        // driving
        carbonFootprint += averages[0]/1 * (driving/3) * 3360

        // phone
        carbonFootprint += averages[1]/195 * (phone/3) * 189

        // appliances
        carbonFootprint += averages[2]/1 * (appliances/3) * 2000

        // eating
        carbonFootprint += averages[3]/1800 * (eat/3) * 4500

        // shower
        carbonFootprint += averages[4]/10 * (shower/3) * 2000

        return carbonFootprint
    }

    func getDrivingCarbon(average: Double) -> Double {
        return average * driving * 1120.0
    }

    func getPhoneCarbon(average: Double) -> Double {
        return average * phone * 0.333
    }

    func getAppliancesCarbon(average: Double) -> Double {
        return average * appliances * 660
    }

    func getEatCarbon(average: Double) -> Double {
            return average * eat * 0.83
    }

    func getShowerCarbon(average: Double) -> Double {
        return average * shower * 3.2
    }
}

var exampleDiaries: [Diary] = [
    Diary(date: Date(timeIntervalSinceNow: -86400), driving: 3, phone: 2, appliances: 4, eat: 3, shower: 2),
    Diary(date: Date(timeIntervalSinceNow: -172800), driving: 4, phone: 2, appliances: 1, eat: 3, shower: 3),
    Diary(date: Date(timeIntervalSinceNow: -259200), driving: 2, phone: 4, appliances: 1, eat: 3, shower: 3),
    Diary(date: Date(timeIntervalSinceNow: -345600), driving: 3, phone: 4, appliances: 1, eat: 3, shower: 2),
    Diary(date: Date(timeIntervalSinceNow: -432000), driving: 5, phone: 5, appliances: 2, eat: 3, shower: 4)
]
