//
//  CarbonsaurusApp.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI
import UserNotifications

@main
struct CarbonsaurusApp: App {
    @State private var selectedTab: Tab = .profile
    @StateObject var viewModel = ViewModel()

    init() {
        UITabBar.appearance().isHidden = true

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Notifications permission granted")
                scheduleDailyNotification()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            if !viewModel.hasOnboarded {
                Onboarding()
                    .environmentObject(viewModel)
            } else {
                ZStack {
                    VStack {
                        TabView(selection: $selectedTab) {
                            ProfileTab().tag(Tab.profile)
                            DiaryTab().tag(Tab.diary)
                            ShopTab().tag(Tab.shop)
                            FeedTab().tag(Tab.feed)
                        }.environmentObject(viewModel)
                    }
                    if viewModel.isTabBarShowing {
                        VStack {
                            Spacer()
                            TabBar(selectedTab: $selectedTab)
                        }
                    }
                }
            }
        }
    }
}
