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
    dateComponents.hour = 7
    dateComponents.minute = 30

    print("Notification scheduled for \(String(describing: dateComponents.hour)) \(String(describing: dateComponents.minute)) p.m.")
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

    // choose a random identifier
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    // add our notification request
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().add(request)
}
