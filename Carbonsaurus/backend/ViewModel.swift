//
//  ViewModel.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var localUser: User
    @Published var hasOnboarded: Bool = false
    @Published var isTabBarShowing: Bool = true
    @Published var hasLoggedToday: Bool = false
    @Published var hasAnsweredDailyQuestion: Bool = false

    init() {
        if let user = DataModel.getLocalUserFromAppStorage() {
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

        DataModel.saveLocalUserToUserDefaults(user: localUser)
    }
    
    func updateLocalUserAvatar(avatarColor: AvatarColor, avatarAccessory: AvatarAccessory, avatarBackground: AvatarBackground) {
        localUser.avatar.color = avatarColor
        localUser.avatar.accessory = avatarAccessory
        localUser.avatar.background = avatarBackground
        
        DataModel.saveLocalUserToUserDefaults(user: localUser)
    }
    
    func resetLocalUser() {
        localUser = User()
        hasOnboarded = false
        hasLoggedToday = false
        hasAnsweredDailyQuestion = false
        DataModel.saveLocalUserToUserDefaults(user: localUser)
    }
    
    func buyShopItem(shopItem: AvatarItem) -> Bool {
        if localUser.buyShopItem(shopItem: shopItem) {
            DataModel.saveLocalUserToUserDefaults(user: localUser)
            return true
        } else {
            return false
        }
    }
}
