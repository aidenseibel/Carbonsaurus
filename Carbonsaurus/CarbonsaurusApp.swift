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
    @StateObject var viewModel = ViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var isTabBarVisisble: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if !viewModel.isLoggedIn{
                Onboarding()
                    .environmentObject(viewModel)
            }else{
                ZStack {
                    VStack {
                        TabView(selection: $selectedTab) {
                            ProfileTab().tag(Tab.profile)
                            DiaryTab().tag(Tab.diary)
                            FeedTab().tag(Tab.feed)
                        }.environmentObject(viewModel)
                    }
                    VStack {
                        Spacer()
                        TabBar(selectedTab: $selectedTab)
                    }
                }
            }
        }
    }
}
