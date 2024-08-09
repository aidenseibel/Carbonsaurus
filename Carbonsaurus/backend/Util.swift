//
//  Util.swift
//  Carbonsaurus
//
//  Created by Yash Shah on 2/24/24.
//

import Foundation

// refreshes the view for whatever reason
class ReloadViewHelper: ObservableObject {
    func reloadView() {
        objectWillChange.send()
    }
}

public func formatDateLong(date: Date) -> String {
    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "EEEE, MMMM d"

    let dateString: String = dateFormatter.string(from: date)

    return dateString.lowercased()
}


public func formatDate(date: Date) -> String {
    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "MMM d"

    let dateString: String = dateFormatter.string(from: date)

    return (dateString + " - " + timeAgoString(from: date)).lowercased()
}

public func getFormattedURLDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}

public func timeAgoString(from date: Date) -> String {

    let calendar = Calendar.current
    let now = Date()
    let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)

    if let years = components.year, years > 0 {
        return "\(years) year\(years == 1 ? "" : "s") ago"
    } else if let months = components.month, months > 0 {
        return "\(months) month\(months == 1 ? "" : "s") ago"
    } else if let days = components.day, days > 1 {
        return "\(days) day\(days == 1 ? "" : "s") ago"
    } else if let days = components.day, let hours = components.hour, hours > 0 {
        return "\(hours + days * 24) hour\(hours == 1 ? "" : "s") ago"
    } else if let minutes = components.minute, minutes > 0 {
        return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
    } else if let seconds = components.second, seconds > 0 {
        return "\(seconds) second\(seconds == 1 ? "" : "s") ago"
    } else {
        return "Just now"
    }
}

public func isLessThanAWeekAgo(date: Date) -> Bool {
    let calendar = Calendar.current
    let currentDate = Date()
    if let difference = calendar.dateComponents([.day], from: date, to: currentDate).day {
        return difference < 7
    }
    return false
}

public func parseNumber(input: String) -> Double {
    return Double(input) ?? 1.0
}

public func getRandomPanorama() -> String{
    let panoramas: [String] = ["meadow", "desert", "lake"]
    return panoramas.randomElement()!
}

func randomDateBetween(beginTime: Date, endTime: Date) -> Date? {
    let timeIntervalStart = beginTime.timeIntervalSince1970
    let timeIntervalEnd = endTime.timeIntervalSince1970

    // Ensure the beginTime is not later than endTime
    guard timeIntervalStart <= timeIntervalEnd else {
        return nil
    }

    // Generate a random time interval between the start and end
    let randomTimeInterval = TimeInterval.random(in: timeIntervalStart...timeIntervalEnd)

    // Create a new date with the random time interval
    return Date(timeIntervalSince1970: randomTimeInterval)
}
