//
//  AppDelegate.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 8/9/24.
//

import SwiftUI
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    // Handle app launch and perform initial setups
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Request notification permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                if UserDefaults.standard.bool(forKey: "notificationsEnabled") {
                    print("Notifications authorized and enabled, scheduling...")
                    self.scheduleNotifications()
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }

        // Set the notification delegate
        UNUserNotificationCenter.current().delegate = self

        return true
    }

    // Handle notification delivery while the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner])
    }

    private func clearNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func scheduleNotifications() {
        // remove all pending notifications
        clearNotifications()
        
        let notificationsEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")
        let randomNotificationsEnabled = UserDefaults.standard.bool(forKey: "randomNotificationsEnabled")
        let beginTime = UserDefaults.standard.object(forKey: "notificationsBeginTime") as! Date
        let endTime = UserDefaults.standard.object(forKey: "notificationsEndTime") as! Date
        
        let content = UNMutableNotificationContent()
        content.title = "Time to check in!"
        content.body = "How much carbon did you use today?"
        content.sound = UNNotificationSound.default
        
        if !notificationsEnabled { return }
        
        var dateComponents = DateComponents()

        if randomNotificationsEnabled {
            dateComponents = Calendar.current.dateComponents([.hour, .minute], from: randomDateBetween(beginTime: beginTime, endTime: endTime)!)
        } else {
            dateComponents = Calendar.current.dateComponents([.hour, .minute], from: beginTime)
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        // create and add new notification request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Notification scheduled for \(String(describing: dateComponents.hour)) \(String(describing: dateComponents.minute)) p.m.")
            }
        }
    }
}
