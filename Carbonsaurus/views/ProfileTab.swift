//
//  ProfileTab.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct ProfileTab: View {
    var body: some View {
        NavigationView{
            ZStack {
                Color.green.opacity(0.30)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading){
                        Text("profile")
                            .bold()
                            .font(.system(size: 42))
                        VStack(alignment: .center, spacing: 30){
                            ZStack{
                                Circle()
                                    .frame(width: UIScreen.main.bounds.width * 0.70)
                                    .foregroundColor(.white)
                                Image("blue_dino_happy")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.width * 0.50)

                            }
                            VStack{
                                Text("your dino is")
                                    .font(.system(size: 20))
                                    .bold()
                                Text("happy")
                                    .font(.system(size: 42))
                                    .bold()
                            }
                            
                            Text("congrats! you’ve done such a good job lately. check out your stats!")
                                .frame(width: UIScreen.main.bounds.width * 0.80)
                                .multilineTextAlignment(.center)
                                .bold()
                            
                            
                            //MARK: STATS
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
                                        Text("12 tons")
                                            .multilineTextAlignment(.leading)
                                            .bold()
                                        Spacer()
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.40)


                                }
                                
                                GridRow{
                                    HStack{
                                        Spacer()
                                        Text("dino points this week")
                                            .multilineTextAlignment(.trailing)
                                            .bold()
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.40)
                                    HStack{
                                        Text("12 tons")
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
                                        Text("12 tons")
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
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.90)
            }
        }
    }
}

#Preview {
    ProfileTab()
}
