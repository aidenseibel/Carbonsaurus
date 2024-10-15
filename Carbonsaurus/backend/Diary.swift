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
    var driving, energy, eat, water: Double

    init(date: Date, driving: Double, energy: Double, eat: Double, water: Double) {
        self.id = UUID()
        self.date = date
        self.driving = driving
        self.energy = energy
        self.eat = eat
        self.water = water
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    func total() -> Double {
        return (driving + energy + eat + water) * 5 / 4
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
        carbonFootprint += getDrivingCarbon(average: averages[0])

        // appliances
        carbonFootprint += getEnergyCarbon(average: averages[1])

        // eating
        carbonFootprint += getEatCarbon(average: averages[2])

        // water
        carbonFootprint += getWaterCarbon(average: averages[3])

        return carbonFootprint
    }

    func getDrivingCarbon(average: Double) -> Double {
        return average * driving * 1120.0
    }

    func getEnergyCarbon(average: Double) -> Double {
        return average * energy * 660
    }

    func getEatCarbon(average: Double) -> Double {
        return average * eat * 0.83
    }

    func getWaterCarbon(average: Double) -> Double {
        return average * water * 3.2
    }
}
