//
//  ProfileTab.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct ProfileTab: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var timer: Timer?
    @State var toggleDino: Bool = false
    @State var openChangeAvatar: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.green.opacity(0.30)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center, spacing: 30) {
                        ZStack {
                            if viewModel.localUser.avatar.background == .no_background{
                                Circle()
                                    .frame(width: UIScreen.main.bounds.width * 0.70)
                                    .foregroundColor(.white)
                            }
                            else{
                                Image(viewModel.localUser.avatar.background.rawValue)
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.70, height: UIScreen.main.bounds.width * 0.70)
                                    .scaledToFill()
                                    .clipped()
                                    .cornerRadius(UIScreen.main.bounds.width * 0.35)
                            }
                            Image(toggleDino ? viewModel.localUser.getAvatarImage() : viewModel.localUser.getAvatarImageOneHigher())
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.width * 0.5)
                                .cornerRadius(50)
                                .clipped()
                                .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                        }
                        .onTapGesture {
                            openChangeAvatar = true
                        }
                        
                        HStack {
                            Spacer()
                            Image("red_purple_flowers")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                            Spacer()
                            VStack(spacing: 5) {
                                Text("your dino is")
                                    .font(.system(size: 20))
                                Text("\(viewModel.localUser.getDinoMood().rawValue)")
                                    .font(.system(size: 42))
                                    .bold()
                                Text(String(format: "%.0f", viewModel.localUser.getDinoPointsThisWeek()) + " dino points this week")
                                    .font(.system(size: 14))
                            }
                            Spacer()
                            Image("red_purple_flowers")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .scaleEffect(x: -1, y: 1)
                            Spacer()
                            
                        }
                        
                        Text("\(viewModel.localUser.getDinoMoodDescription())")
                            .frame(width: UIScreen.main.bounds.width * 0.80)
                            .multilineTextAlignment(.center)
                        
                        NavigationLink(destination: {
                            StatsView()
                        }, label: {
                            Text("view my stats")
                                .padding(15)
                                .background(.white)
                                .cornerRadius(10)
                        })
                        .buttonStyle(.plain)
                    }
                    .padding(10)
                }
            }
            .navigationTitle("my dino")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: {
                    SettingsView()
                }, label: {
                    Image(systemName: "gear")}
                )
            )
            .sheet(isPresented: $openChangeAvatar, onDismiss: {
                openChangeAvatar = false
            }, content: {
                ChangeAvatarView(selectedAvatarColor: viewModel.localUser.avatar.color, selectedAvatarAccessory: viewModel.localUser.avatar.accessory, selectedAvatarBackground: viewModel.localUser.avatar.background)
            })
        }
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { _ in
                toggleDino.toggle()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

#Preview {
    ProfileTab()
}
