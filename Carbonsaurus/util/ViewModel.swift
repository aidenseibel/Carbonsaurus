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
    
    init(){
        if let user = DataModel.getLocalUserFromAppStorage(){
            localUser = user
            hasOnboarded = true
            
            hasLoggedToday = localUser.diaries.filter { Calendar.current.isDate($0.date, inSameDayAs: Date.now) }.count > 0
            
        }else{
            localUser = User(username: "default account", diaries: exampleDiaries, avatar: Avatar(color: .orange, mood: .neutral, accessory: nil), extraDinoPoints: 0, average_driving: 1, average_phone: 195, average_appliances: 1, average_eating: 1800, average_shower: 10)
        }
    }
    
    func addDiary(diary: Diary){
        localUser.diaries.append(diary)
        hasLoggedToday = true
        isTabBarShowing = true
        print("Added diary to localUser. Saving to UserDefaults...")
        
        DataModel.saveLocalUserToUserDefaults(user: localUser)
    }
}
