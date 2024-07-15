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
    @State var viewStats: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.green.opacity(0.30)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center, spacing: 25) {
                        ZStack {
                            if viewModel.localUser.avatar.background == .no_background{
                                Circle()
                                    .frame(width: UIScreen.main.bounds.width * 0.60)
                                    .foregroundColor(.white)
                            }
                            else{
                                Image(viewModel.localUser.avatar.background.rawValue)
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.60, height: UIScreen.main.bounds.width * 0.60)
                                    .scaledToFill()
                                    .clipped()
                                    .cornerRadius(UIScreen.main.bounds.width * 0.30)
                            }
                            Image(toggleDino ? viewModel.localUser.avatar.getImageString() : viewModel.localUser.avatar.getHigherImageString())
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
                                Text("\(viewModel.localUser.getDinoStatus().rawValue)")
                                    .font(.system(size: 42))
                                    .bold()
                                Text("\(viewModel.localUser.getDinoPoints()) dino points")
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
                        
                        Text("\(viewModel.localUser.getDinoStatusDescription())")
                            .frame(width: UIScreen.main.bounds.width * 0.80)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            viewStats = true
                        } label: {
                            Text("view your stats here!")
                                .foregroundColor(.green.opacity(0.55))
                                .buttonStyle(.plain)
                                .padding(20)
                                .bold()
                                .background(.white)
                                .cornerRadius(10)
                        }

                        NavigationLink(destination: UpdateAveragesView()) {
                            Text("update my averages")
                                .foregroundColor(.green.opacity(0.55))
                                .buttonStyle(.plain)
                                .padding(20)
                                .bold()
                                .background(.white)
                                .cornerRadius(10)
                                .padding(.bottom, 100)
                        }
                    }
                    .padding(10)
                }
            }
            .navigationTitle("profile")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $openChangeAvatar, onDismiss: {
                openChangeAvatar = false
            }, content: {
                ChangeAvatarView(selectedAvatarColor: viewModel.localUser.avatar.color, selectedAvatarAccessory: viewModel.localUser.avatar.accessory, selectedAvatarBackground: viewModel.localUser.avatar.background)
            })
            .sheet(isPresented: $viewStats, onDismiss: {
                viewStats = false
            }, content: {
                StatsView()
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
