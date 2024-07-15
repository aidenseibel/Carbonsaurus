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

    init() {
        if let user = DataModel.getLocalUserFromAppStorage() {
            localUser = user
            hasOnboarded = true

            hasLoggedToday = localUser.diaries.filter { Calendar.current.isDate($0.date, inSameDayAs: Date.now) }.count > 0
        } else {
            localUser = User(username: "default account", diaries: exampleDiaries, avatar: Avatar(color: .orange, mood: .neutral, accessory: .no_accessory, background: .no_background), extraDinoPoints: 0, averageDriving: 1, averagePhone: 195, averageAppliances: 1, averageEating: 1800, averageShower: 10)
        }
    }

    func addDiary(diary: Diary) {
        localUser.diaries.append(diary)
        hasLoggedToday = true
        isTabBarShowing = true
        print("Added diary to localUser. Saving to UserDefaults...")

        DataModel.saveLocalUserToUserDefaults(user: localUser)
    }
}
