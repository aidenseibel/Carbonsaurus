//
//  CarbonsaurusApp.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI
import UserNotifications
import WidgetKit

@main
struct CarbonsaurusApp: App {
    @State private var selectedTab: Tab = .profile
    @StateObject var viewModel = ViewModel()
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            if !viewModel.hasOnboarded {
                Onboarding()
                    .environmentObject(viewModel)
            } else if !viewModel.hasCompletedTutorial {
                Tutorial()
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
        }.onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .background || newPhase == .active {
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
}
