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
                if let localUser = DataModel.getLocalUser() {
                    DataModel.scheduleNotifications(enabled: localUser.notificationsEnabled, notificationTime: localUser.notificationTime)
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
}
