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
    var driving, energy, eat, shower: Double

    init(date: Date, driving: Double, energy: Double, eat: Double, shower: Double) {
        self.id = UUID()
        self.date = date
        self.driving = driving
        self.energy = energy
        self.eat = eat
        self.shower = shower
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    func total() -> Double {
        return driving + energy + eat + shower
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

        // appliances
        carbonFootprint += averages[1]/1 * (energy/3) * 2000

        // eating
        carbonFootprint += averages[2]/1800 * (eat/3) * 4500

        // shower
        carbonFootprint += averages[3]/10 * (shower/3) * 2000

        return carbonFootprint
    }

    func getDrivingCarbon(average: Double) -> Double {
        return average * driving * 1120.0
    }

    func getAppliancesCarbon(average: Double) -> Double {
        return average * energy * 660
    }

    func getEatCarbon(average: Double) -> Double {
            return average * eat * 0.83
    }

    func getShowerCarbon(average: Double) -> Double {
        return average * shower * 3.2
    }
}
