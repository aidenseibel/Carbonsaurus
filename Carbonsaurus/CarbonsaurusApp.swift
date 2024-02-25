//
//  CarbonsaurusApp.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

@main
struct CarbonsaurusApp: App {
    @State private var selectedTab: Tab = .profile
    
    init() {
        localuser = user(username: "default account", diaries: exampleDiaries, avatar: avatar.orange, avatarStatus: .great, average_driving: 1, average_phone: 195, average_appliances: 1, average_eating: 1800, average_shower: 10)
        UITabBar.appearance().isHidden = true
    }
    
    var localuser: user
    var isTabBarVisisble: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                VStack {
                    TabView(selection: $selectedTab) {
                        ProfileTab().tag(Tab.profile)
                        DiaryTab().tag(Tab.diary)
                        FeedTab().tag(Tab.feed)
                    }.environmentObject(localuser)
                }
                VStack {
                    Spacer()
                    TabBar(selectedTab: $selectedTab)

                }

            }
        }
    }
}
