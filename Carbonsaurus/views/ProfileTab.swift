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
        NavigationView{
            ZStack {
                Color.green.opacity(0.30)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading){
                        VStack(alignment: .center, spacing: 30){
                            ZStack{
                                Circle()
                                    .frame(width: UIScreen.main.bounds.width * 0.70)
                                    .foregroundColor(.white)
                                Image(toggleDino ? viewModel.localuser.getDinoImageString() : viewModel.localuser.getHigherDinoImageString())
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.width * 0.50)
                                    .onTapGesture {
                                        openChangeAvatar = true
                                    }
                                
                            }
                            HStack{
                                Spacer()
                                Image("flower")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 70)
                                    .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                                Spacer()
                                VStack{
                                    Text("your dino is")
                                        .font(.system(size: 20))
                                        .bold()
                                    Text("\(viewModel.localuser.dinoStatusToString())")
                                        .font(.system(size: 42))
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
                            
                            
                            //MARK: WEEK STATS
                            Grid(alignment: .trailing, horizontalSpacing: 20, verticalSpacing: 10){
                                GridRow{
                                    HStack{
                                        Spacer()
                                        Text("carbon footprint this week")
                                            .multilineTextAlignment(.trailing)
                                            .bold()
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.40)
                                    
                                    HStack{
                                        Text("\(viewModel.localuser.getCarbonFootprintThisWeek()/1000) kg")
                                            .multilineTextAlignment(.leading)
                                            .bold()
                                        Spacer()
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.40)
                                }
                                
                                GridRow{
                                    HStack{
                                        Spacer()
                                        Text("avg. dino points this week")
                                            .multilineTextAlignment(.trailing)
                                            .bold()
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.40)
                                    HStack{
                                        Text("\(viewModel.localuser.getAverageDinoPointsThisWeek())")
                                            .multilineTextAlignment(.leading)
                                            .bold()
                                        Spacer()
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.40)
                                }
                                
                                GridRow{
                                    HStack{
                                        Spacer()
                                        Text("your carbon ranking")
                                            .multilineTextAlignment(.trailing)
                                            .bold()
                                    }
                                    HStack{
                                        Text("\(viewModel.localuser.getCarbonRanking())")
                                            .multilineTextAlignment(.leading)
                                            .bold()
                                        Spacer()
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.40)
                                }
                            }
                            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                            .background(.white)
                            .cornerRadius(10)
                            

                            HStack{
                                Spacer()
                                Image("tree")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 70)
                                    .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                                Spacer()
                                Text("overall stats")
                                    .bold()
                                    .font(.title2)
                                Spacer()
                                Image("tree")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 70)
                                    .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                                Spacer()
                            }
                            //MARK: STATS
                            Grid(alignment: .trailing, horizontalSpacing: 20, verticalSpacing: 10){
                                GridRow{
                                    HStack{
                                        Spacer()
                                        Text("total dino points")
                                            .multilineTextAlignment(.trailing)
                                            .bold()
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.40)
                                    
                                    HStack{
                                        Text("\(viewModel.localuser.getDinoPoints())")
                                            .multilineTextAlignment(.leading)
                                            .bold()
                                        Spacer()
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.40)
                                    
                                    
                                }
                                
                                GridRow{
                                    HStack{
                                        Spacer()
                                        Text("diaries")
                                            .multilineTextAlignment(.trailing)
                                            .bold()
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.40)
                                    HStack{
                                        Text("\(viewModel.localuser.diaries.count)")
                                            .multilineTextAlignment(.leading)
                                            .bold()
                                        Spacer()
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.40)
                                }
                                
                                GridRow{
                                    HStack{
                                        Spacer()
                                        Text("average dino points")
                                            .multilineTextAlignment(.trailing)
                                            .bold()
                                    }
                                    HStack{
                                        Text("\(viewModel.localuser.getDinoPoints() / viewModel.localuser.diaries.count)")
                                            .multilineTextAlignment(.leading)
                                            .bold()
                                        Spacer()
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.40)
                                }
                            }
                            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
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
