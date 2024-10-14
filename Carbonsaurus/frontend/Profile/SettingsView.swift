//
//  SettingsView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 7/29/24.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var showResetProfileAlert = false
    @State private var showNotificationsStatusAlert = false
    @State private var notificationsEnabled: Bool = false
    @State private var notificationTime: Date = Calendar.current.date(bySettingHour: 19, minute: 30, second: 0, of: Date())!
    
    let feedbackURL: String = "https://docs.google.com/forms/d/e/1FAIpQLSfplFd6iwdxJsuwOfcqwMxBIns6dIeCQavuvyBVPNxuRKFuQA/viewform?usp=sf_link"

    var body: some View {
        ZStack {
            Color.green.opacity(0.30)
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 25) {
                    // MARK: NOTIFICATIONS
                    Text("notifications")
                        .font(.title2)
                        .bold()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Toggle("enable notifications", isOn: $notificationsEnabled)  // Toggle switch
                            .onChange(of: notificationsEnabled) {
                                viewModel.setNotificationsEnabled(enabled: notificationsEnabled)
                            }
                            .alert(isPresented: $showNotificationsStatusAlert) {
                                Alert(title: Text("Notifications Not Authorized"),
                                      message: Text("Authorize notifications in settings?"),
                                      primaryButton: .default(Text("Go to Settings")) {
                                    if let url = URL(string: UIApplication.openSettingsURLString) {
                                        UIApplication.shared.open(url)
                                    }
                                },
                                      secondaryButton: .cancel())
                            }
                        
                        if notificationsEnabled {
                            Text("you will be notified for up to three days after the last time you opened the app.")
                                .font(.system(size: 12))
                        }
                    }

                    // MARK: NOTIFICATION TIME
                    VStack(alignment: .leading, spacing: 10) {
                        if notificationsEnabled {  // Show time picker only if notifications are enabled
                            VStack(alignment: .leading, spacing: 20) {
                                DatePicker(
                                    "notification time",
                                    selection: $notificationTime,
                                    displayedComponents: .hourAndMinute
                                )
                                .onChange(of: notificationTime) {
                                    viewModel.setNotificationTime(time: notificationTime)
                                }
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(10)
                        }
                    }

                    Divider()
                    
                    
                    // MARK: PROFILE
                    Text("profile")
                        .font(.title2)
                        .bold()
                    
                    // update user averages
                    NavigationLink {
                        UpdateAveragesView()
                    } label: {
                        Text("update my averages")
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)

                    // Reset profile button section
                    Button {
                        showResetProfileAlert = true
                    } label: {
                        Text("reset my profile")
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .alert(isPresented: $showResetProfileAlert) {
                        Alert(
                            title: Text("Confirm Reset"),
                            message: Text("Are you sure you want to reset your profile?"),
                            primaryButton: .destructive(Text("Reset")) {
                                viewModel.resetLocalUser()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    
                    Divider()
                    
                    Text("other")
                        .font(.title2)
                        .bold()
                    
                    // feedback link
                    Link(destination: URL(string: feedbackURL) ?? URL(string: "about:blank")!, label: {
                        Text("provide feedback")
                    })
                    .buttonStyle(.plain)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    
                    // about the app
                    NavigationLink {
                        AboutCarbonsaurusView()
                    } label: {
                        Text("about the app")
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)

                    
                    Text("Last updated October 2024")
                        .padding(.bottom, 50)
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                }
                .padding()
            }
            .navigationTitle("settings")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear{
            notificationsEnabled = viewModel.localUser.notificationsEnabled
            notificationTime = viewModel.localUser.notificationTime
        }
    }
    
    //MARK: FUNCTIONS
    // converts Date to DateComponents
    func getDateComponents(date: Date) -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return components
    }
}

#Preview {
    SettingsView()
}
