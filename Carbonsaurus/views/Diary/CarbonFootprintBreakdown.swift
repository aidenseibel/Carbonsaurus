//
//  CarbonFootprintBreakdown.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct CarbonFootprintBreakdown: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @EnvironmentObject var viewModel: ViewModel
    @State private var timer: Timer?
    @State var toggleDino: Bool = false
    @State var openChangeAvatar: Bool = false
    @State var viewStats: Bool = false
    @Namespace var totalOutputID

    
    var body: some View {
        NavigationView{
            ZStack {
                Color.green.opacity(0.30)
                    .ignoresSafeArea()
                ScrollViewReader{ proxy in
                    ScrollView(showsIndicators: false){
                        VStack(alignment: .leading){
                            Group{
                                Text("how much carbon do you ")
                                    .font(.title)
                                    .bold()
                                Text("really")
                                    .font(.system(size: 42))
                                    .italic()
                                    .bold()
                                Text("use?")
                                    .font(.title2)
                                    .bold()
                                    .padding(.bottom, 4)

                                .padding(.bottom, 50)
                                Text("that's a very difficult question, but let's try to break it down:")
                                    .bold()
                                    .padding(.bottom, 30)
                                Text("let's find out!:")
                                    .bold()
                                    .padding(.bottom, 100)
                            }

                            HStack{
                                Spacer()
                                Image("light_green_dino_happy")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.width * 0.5)
                                    .cornerRadius(20)
                                    .clipped()
                                    .padding(.bottom, 100)
                                Spacer()
                            }
                            
                            Group{
                                Text("estimate total carbon output:")
                                    .bold()
                                    .tag(totalOutputID)
                                Text("\(viewModel.localuser.getAverageDinoPoints() * 365 / 100)")
                                    .font(.system(size: 42))
                                    .italic()
                                    .bold()
                                Text("kilograms of carbon.")
                                    .bold()
                                    .padding(.bottom, 50)
                                Text("wow! that's a lot!")
                                    .bold()
                                    .padding(.bottom, 20)
                                Text("the average american uses about 14,500 kilograms per year.")
                                    .bold()
                                    .padding(.bottom, 20)
                                if (viewModel.localuser.getAverageDinoPoints() * 365 / 100) < 14500{
                                    Text("give yourself a pat on the back for doing better than most!")
                                        .bold()
                                        .padding(.bottom, 20)
                                }else{
                                    Text("there's surely room for improvement here.")
                                        .bold()
                                        .padding(.bottom, 20)
                                }
                                Text("but just how much is that?")
                                    .bold()
                                    .padding(.bottom, 100)
                            }
                            
                            HStack{
                                Spacer()
                                Image("blue_dino_happy")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.width * 0.5)
                                    .cornerRadius(20)
                                    .clipped()
                                    .padding(.bottom, 100)
                                Spacer()
                            }
                            
                            Group{
                                Text("a single commercial flight from LA to New York expends upwards of")
                                    .bold()
                                    .tag(totalOutputID)
                                Text("50,000-100,000")
                                    .font(.system(size: 42))
                                    .italic()
                                    .bold()
                                Text("kilograms of carbon.")
                                    .bold()
                                    .padding(.bottom, 20)
                                Text("this is \(50000/(viewModel.localuser.getAverageDinoPoints() * 365 / 100)) - \(100000/(viewModel.localuser.getAverageDinoPoints() * 365 / 100)) times your yearly carbon output.")
                                    .bold()
                                    .padding(.bottom, 20)
                                Text("while this may dwarf what you expend yearly, remember neither case is good for our planet.")
                                    .bold()
                                    .padding(.bottom, 100)
                            }

                            HStack{
                                Spacer()
                                Image("pink_dino_worried")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.width * 0.5)
                                    .cornerRadius(20)
                                    .clipped()
                                    .padding(.bottom, 100)
                                Spacer()
                            }

                            Group{
                                Text("it takes")
                                    .bold()
                                    .tag(totalOutputID)
                                Text("\((viewModel.localuser.getAverageDinoPoints() * 365 / 100)/48)")
                                    .font(.system(size: 42))
                                    .italic()
                                    .bold()
                                Text("trees to offset your carbon output alone.")
                                    .bold()
                                    .padding(.bottom, 100)
                            }
                            
                        
                            HStack{
                                Spacer()
                                Image("green_dino_worried")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.width * 0.5)
                                    .cornerRadius(20)
                                    .clipped()
                                    .padding(.bottom, 100)
                                Spacer()
                            }
                            
                            
                            Group{
                                Text("so what can you do to help the planet out?")
                                    .bold()
                                Text("the best thing to do is")
                                    .bold()
                                Text("be aware.")
                                    .font(.system(size: 42))
                                    .italic()
                                    .bold()
                                Text("by using this app, you've taken the first step in being climate aware!")
                                    .bold()
                                    .padding(.bottom, 100)
                            }
                            
                            HStack{
                                Spacer()
                                Image("orange_dino_great")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.width * 0.5)
                                    .cornerRadius(20)
                                    .clipped()
                                    .padding(.bottom, 100)
                                Spacer()
                            }

                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                                viewModel.isTabBarShowing = true
                            } label: {
                                HStack{
                                    Spacer()
                                    Text("home")
                                        .bold()
                                        .foregroundColor(.green.opacity(0.55))
                                        .padding(20)
                                        .background(.white)
                                        .cornerRadius(10)
                                    Spacer()
                                }
                            }
                            .padding(.bottom, 100)

                        }
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.90)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            viewModel.isTabBarShowing = false
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
    CarbonFootprintBreakdown()
}
