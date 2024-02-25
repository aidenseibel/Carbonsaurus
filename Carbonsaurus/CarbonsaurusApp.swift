//
//  CarbonsaurusApp.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

@main
struct CarbonsaurusApp: App {
    init() {
        localuser = user(username: "default account", diaries: exampleDiaries, avatar: avatar.orange, avatarStatus: .great, average_driving: 1, average_phone: 195, average_appliances: 1, average_eating: 1800, average_shower: 10)
    }
    
    var localuser: user
    
    var body: some Scene {
        WindowGroup {
            TabView{
                ProfileTab()
                    .tabItem {
                        Label("profile", systemImage: "tree.circle.fill")
                    }
                DiaryTab()
                    .tabItem {
                        Label("diary", systemImage: "sun.and.horizon.fill")
                    }
                FeedTab()
                    .tabItem {
                        Label("feed", systemImage: "globe.europe.africa.fill")
                    }
            }
            .environmentObject(localuser)
        }
    }
}
