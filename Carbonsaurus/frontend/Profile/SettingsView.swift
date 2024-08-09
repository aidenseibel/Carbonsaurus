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
    @State private var notificationsEnabled = false
    @State private var randomNotificationsEnabled = false
    @State private var notificationBeginTime = Date()
    @State private var notificationEndTime = Date()

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
                                setNotificationsEnabled()
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

                    //MARK: RANDOM TIME
                    VStack(alignment: .leading, spacing: 10) {
                        if notificationsEnabled {  // Show time picker only if notifications are enabled
                            Toggle("random time", isOn: $randomNotificationsEnabled)
                                .onChange(of: randomNotificationsEnabled) {
                                    setRandomNotificationsEnabled()
                                }

                            if randomNotificationsEnabled {
                                Text("you will be notified at a random time within the selected range to check in.")
                                    .font(.system(size: 12))
                            }
                            
                            VStack(alignment: .leading, spacing: 20) {
                                DatePicker(
                                    (randomNotificationsEnabled ? "start time" : "notification time"),
                                    selection: $notificationBeginTime,
                                    displayedComponents: .hourAndMinute
                                )
                                .onChange(of: notificationBeginTime) {
                                    setNotificationBeginTime()
                                }
                                
                                if randomNotificationsEnabled {
                                    DatePicker(
                                        "end time",
                                        selection: $notificationEndTime,
                                        displayedComponents: .hourAndMinute
                                    )
                                    .onChange(of: notificationEndTime) {
                                        setNotificationEndTime()
                                    }
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
                                presentationMode.wrappedValue.dismiss()
                                viewModel.resetLocalUser()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("settings")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear{
            notificationsEnabled = getNotificationsEnabled()
            randomNotificationsEnabled = getRandomNotificationsEnabled()
            notificationBeginTime = getNotificationsBeginTime()
            notificationEndTime = getNotificationsEndTime()
        }
    }
    
    //MARK: FUNCTIONS
    
    // converts Date to DateComponents
    func getDateComponents(date: Date) -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return components
    }

    func checkNotificationAuthorized(completion: @escaping (Bool) -> Void) {
        print("checking notification status...")
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized, .provisional:
                    print("authorized")
                    completion(true)
                case .denied, .notDetermined, .ephemeral:
                    print("not authorized")
                    completion(false)
                @unknown default:
                    print("not authorized")
                    completion(false)
                }
            }
        }
    }

    func getNotificationsEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: "notificationsEnabled")
    }
    
    func getRandomNotificationsEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: "randomNotificationsEnabled")
    }
    
    func getNotificationsBeginTime() -> Date {
        if let date =  UserDefaults.standard.object(forKey: "notificationsBeginTime") as? Date {
            return date
        } else {
            return Calendar.current.date(bySettingHour: 18, minute: 30, second: 0, of: Date())!
        }
    }
    
    func getNotificationsEndTime() -> Date {
        if let date =  UserDefaults.standard.object(forKey: "notificationsEndTime") as? Date {
            return date
        } else {
            return Calendar.current.date(bySettingHour: 19, minute: 30, second: 0, of: Date())!
        }
    }

    
    //MARK: SETTERS
    func setNotificationsEnabled() {
        if notificationsEnabled {
            checkNotificationAuthorized { isAuthorized in
                if !isAuthorized {
                    showNotificationsStatusAlert = true
                    notificationsEnabled = false
                } else {
                    UserDefaults.standard.setValue(notificationsEnabled, forKey: "notificationsEnabled")
                    print("enabled notifications")
                }
            }
        } else {
            UserDefaults.standard.setValue(notificationsEnabled, forKey: "notificationsEnabled")
            print("disabled notifications")
        }
    }
    
    func setRandomNotificationsEnabled() {
        UserDefaults.standard.setValue(randomNotificationsEnabled, forKey: "randomNotificationsEnabled")
    }
    
    func setNotificationBeginTime() {
        UserDefaults.standard.setValue(notificationBeginTime, forKey: "notificationsBeginTime")
        
        // to ensure that the beginning time cannot be after the end time
        setNotificationEndTime()
    }
    
    func setNotificationEndTime() {
        // Check if the end time is earlier than the begin time
        if notificationEndTime <= notificationBeginTime {
            // Reset end time to the same as begin time
            notificationEndTime = notificationBeginTime
            // Optionally, you could show an alert to inform the user
            // Here you can add your own alert logic if needed
        }
        UserDefaults.standard.setValue(notificationEndTime, forKey: "notificationsEndTime")
    }
}

#Preview {
    SettingsView()
}
