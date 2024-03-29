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
        NavigationView{
            ZStack {
                Color.green.opacity(0.30)
                    .ignoresSafeArea()
                VStack(alignment: .leading){
                    VStack(alignment: .center, spacing: 25){
                        ZStack{
                            Circle()
                                .frame(width: UIScreen.main.bounds.width * 0.60)
                                .foregroundColor(.white)
                            Image(toggleDino ? viewModel.localuser.getDinoImageString() : viewModel.localuser.getHigherDinoImageString())
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

                        HStack{
                            Spacer()
                            Image("flower")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                            Spacer()
                            VStack(spacing: 5){
                                Text("your dino is")
                                    .font(.system(size: 20))
                                    .bold()
                                Text("\(viewModel.localuser.dinoStatusToString())")
                                    .font(.system(size: 42))
                                    .bold()
                                Text("\(viewModel.localuser.getDinoPoints()) dino points")
                                    .font(.system(size: 14))
                                    .bold()

                            }
                            Spacer()
                            Image("flower")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                            Spacer()

                        }
                        
                        Text("\(viewModel.localuser.getDinoStatusDescription())")
                            .frame(width: UIScreen.main.bounds.width * 0.80)
                            .multilineTextAlignment(.center)
                            .bold()
                        
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
                                .padding(.bottom, 100)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.90)
            }
            .navigationTitle("profile")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $openChangeAvatar, onDismiss: {
                openChangeAvatar = false
            }, content: {
                ChangeAvatarView()
            })
            .sheet(isPresented: $viewStats, onDismiss: {
                viewStats = false
            }, content: {
                StatsView()
            })

        }
        .onAppear{
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                toggleDino.toggle()
            }
        }
        .onDisappear{
            timer?.invalidate()
        }
    }
}


#Preview {
    ProfileTab()
}
