//
//  ViewModel.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var localuser: user
    @Published var isLoggedIn: Bool = false
    @Published var isTabBarShowing: Bool = true
    @Published var hasLoggedToday: Bool = false
    
    init(){
        localuser = user(username: "default account", diaries: exampleDiaries, avatar: avatar.orange, avatarStatus: .great, average_driving: 1, average_phone: 195, average_appliances: 1, average_eating: 1800, average_shower: 10)
    }
}
