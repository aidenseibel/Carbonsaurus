//
//  ChangeAvatarView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct ChangeAvatarView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var timer: Timer?
    @State var index: Int = 0

    var body: some View {
        ZStack{
            Color.yellow.opacity(0.50)
                .ignoresSafeArea()
            ScrollView(showsIndicators: false){
                VStack{
                    HStack{
                        Text("change your avatar")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding(.top, 40)
                    
                    Grid(alignment: .center, horizontalSpacing: 20, verticalSpacing: 20){
                        GridRow{
                            Button(action: {
                                viewModel.localuser.avatar = .blue
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image("blue_dino_\(getFromIndex())")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.width * 0.40)
                                    .cornerRadius(10)
                            })
                            
                            Button(action: {
                                viewModel.localuser.avatar = .green
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image("green_dino_\(getFromIndex())")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.width * 0.40)
                                    .cornerRadius(10)
                            })
                        }
                        GridRow{
                            Button(action: {
                                viewModel.localuser.avatar = .pink
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image("pink_dino_\(getFromIndex())")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.width * 0.40)
                                    .cornerRadius(10)
                            })
                            Button(action: {
                                viewModel.localuser.avatar = .orange
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image("orange_dino_\(getFromIndex())")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.width * 0.40)
                                    .cornerRadius(10)
                            })

                        }
                        GridRow{
                            Button(action: {
                                viewModel.localuser.avatar = .light_green
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image("light_green_dino_\(getFromIndex())")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.width * 0.40)
                                    .cornerRadius(10)
                            })
                            Text("")
                                .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.width * 0.40)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.90)
            .onAppear{
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    index = index + 1
                    if index > 4{
                        index = 0
                    }
                }
            }
            .onDisappear{
                timer?.invalidate()
            }
        }
    }
    
    func getFromIndex() -> String{
        switch index{
        case 0:
            return "great"
        case 1:
            return "happy"
        case 2:
            return "neutral"
        case 3:
            return "worried"
        case 4:
            return "sad"
        default:
            return "happy"
        }
    }
}

#Preview {
    ChangeAvatarView()
}
