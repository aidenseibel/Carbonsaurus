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
        localuser = user(username: "default account", diaries: exampleDiaries, avatar: avatar.orange, avatarStatus: .great)
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
