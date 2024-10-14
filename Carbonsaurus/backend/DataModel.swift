//
//  DataModel.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 5/11/24.
//

import Foundation
import UserNotifications

struct DataModel {
    // saves the local user locally, returns true if successful.
    // since User is already Codable, most of the work is done for us.
    static func saveLocalUser(user: User) -> Bool {
        do {
            // encode the user
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)

            // save and return true
            if let userDefaults = UserDefaults(suiteName: "group.com.carbonsaurus.app.identifier") {
                userDefaults.setValue(data, forKey: "localUser")
            }

            print("Successfully saved localUser to UserDefaults")
            return true
        } catch {
            print("Unable to encode localUser when setting to UserDefaults: \(error)")
        }
        return false
    }

    
    // loads in the local user on launch.
    static func getLocalUser() -> User? {
        if let userDefaults = UserDefaults(suiteName: "group.com.carbonsaurus.app.identifier") {
            // Safely unwrap the value for the key "localUser"
            if let data = userDefaults.value(forKey: "localUser") as? Data {
                do {
                    // Try to decode
                    let decoder = JSONDecoder()
                    let localUser = try decoder.decode(User.self, from: data)
                    print("Successfully fetched localUser from UserDefaults")
                    return localUser
                } catch {
                    print("Unable to decode localUser when getting from UserDefaults: \(error)")
                }
            } else {
                print("No data found for key 'localUser' in UserDefaults")
            }
        } else {
            print("UserDefaults suite is nil")
        }
        return nil
    }

    
    static func clearNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    
    // checks authorization
    static func scheduleNotifications(enabled: Bool, notificationTime: Date) {
        // remove all pending notifications
        DataModel.clearNotifications()
        
        if !enabled { return }

        // check authorization
        checkNotificationAuthorization { granted in
            if !granted { return }

            let content = UNMutableNotificationContent()

            content.title = "Time to check in!"
            content.body = "How much carbon did you use today?"
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents = Calendar.current.dateComponents([.hour, .minute], from: notificationTime)

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


    static func checkNotificationAuthorization(completion: @escaping (Bool) -> Void) {
        print("checking notification status...")
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized, .provisional:
                    print("authorized")
                    completion(true)
                case .denied, .notDetermined, .ephemeral:
                    print("not authorized")
                    completion(false)
                @unknown default:
                    print("not authorized")
                    completion(false)
                }
            }
        }
    }
}
