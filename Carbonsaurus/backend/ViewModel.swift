//
//  ViewModel.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import Foundation

public class ViewModel: ObservableObject {
    @Published var localUser: User
    @Published var hasOnboarded: Bool = false
    @Published var isTabBarShowing: Bool = true
    @Published var hasLoggedToday: Bool = false
    @Published var hasAnsweredDailyQuestion: Bool = false

    init() {
        if let user = DataModel.getLocalUser() {
            localUser = user
            hasOnboarded = true

            hasLoggedToday = localUser.diaries.filter { Calendar.current.isDate($0.date, inSameDayAs: Date.now) }.count > 0
            hasAnsweredDailyQuestion = localUser.dailyQuizzes.filter { Calendar.current.isDate($0.date, inSameDayAs: Date.now) }.count > 0
        } else {
            localUser = User()
        }
    }

    func addDiary(diary: Diary) {
        localUser.addDiary(diary: diary)
        hasLoggedToday = true
        print("Added diary to localUser. Saving to UserDefaults...")

        DataModel.saveLocalUser(user: localUser)
    }
    
    func updateLocalUserAvatar(avatarColor: AvatarColor, avatarAccessory: AvatarAccessory, avatarBackground: AvatarBackground) {
        localUser.avatar.color = avatarColor
        localUser.avatar.accessory = avatarAccessory
        localUser.avatar.background = avatarBackground
        
        DataModel.saveLocalUser(user: localUser)
    }
    
    func resetLocalUser() {
        DataModel.clearNotifications()
        
        hasOnboarded = false
        hasLoggedToday = false
        hasAnsweredDailyQuestion = false
        
        localUser = User()

        DataModel.saveLocalUser(user: localUser)
    }
    
    func buyShopItem(shopItem: AvatarItem) -> Bool {
        if localUser.buyShopItem(shopItem: shopItem) {
            DataModel.saveLocalUser(user: localUser)
            return true
        } else {
            return false
        }
    }
    
    func setNotificationsEnabled(enabled: Bool) {
        localUser.notificationsEnabled = enabled
        DataModel.saveLocalUser(user: localUser)
        
        // note that this does authorization checks and clears all pending notifications
        DataModel.scheduleNotifications(enabled: enabled, notificationTime: localUser.notificationTime)
    }
    
    func setNotificationTime(time: Date) {
        localUser.notificationTime = time
        DataModel.saveLocalUser(user: localUser)
        
        if localUser.notificationsEnabled {
            DataModel.scheduleNotifications(enabled: true, notificationTime: localUser.notificationTime)
        }
    }
}
