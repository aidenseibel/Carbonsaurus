//
//  Notifications.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 5/14/24.
//

import Foundation
import UserNotifications

func scheduleDailyNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Time to check in!"
    content.body = "How much carbon did you use today?"
    content.sound = UNNotificationSound.default
    
    var dateComponents = DateComponents()
    dateComponents.hour = Int.random(in: 17...20)
    dateComponents.minute = Int.random(in: 0...59)

    print("Notification scheduled for \(String(describing: dateComponents.hour)) \(String(describing: dateComponents.minute)) p.m.")
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

    // choose a random identifier
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    // add our notification request
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().add(request)
}
