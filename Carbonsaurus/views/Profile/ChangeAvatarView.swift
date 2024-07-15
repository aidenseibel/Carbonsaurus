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
    
    @State var selectedAvatarColor: AvatarColor
    @State var selectedAvatarAccessory: AvatarAccessory

    var body: some View {
        ZStack {
            Color.yellow.opacity(0.50)
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 30) {
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("cancel")
                        }
                        
                        Spacer()
                        
                        Button {
                            viewModel.localUser.avatar.color = selectedAvatarColor
                            viewModel.localUser.avatar.accessory = selectedAvatarAccessory
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("save")
                        }
                    }
                    ZStack {
                        Circle()
                            .frame(width: UIScreen.main.bounds.width * 0.60)
                            .foregroundColor(.white)
                        Image("\(selectedAvatarColor)_dino_happy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.width * 0.5)
                            .cornerRadius(50)
                            .clipped()
                    }

                    VStack(alignment: .leading){
                        Text("choose your dino")
                            .font(.title2)
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(allAvatarColors, id: \.self) { avatarColor in
                                    ZStack{
                                        Color.black
                                        Button(action: {
                                            selectedAvatarColor = avatarColor
                                        }, label: {
                                            Image("\(avatarColor.rawValue)_dino_happy")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                                        })
                                        .opacity(selectedAvatarColor == avatarColor ? 1.0 : 0.70)
                                    }
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading){
                        Text("accessories")
                            .font(.title2)
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(allAvatarAccessories, id: \.self) { avatarAccessory in
                                    ZStack{
                                        Color.black
                                        Button(action: {
                                            selectedAvatarAccessory = avatarAccessory
                                        }, label: {
                                            Image(avatarAccessory.rawValue)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                                        })
                                            .background(.white)
                                            .opacity(selectedAvatarAccessory == avatarAccessory ? 1.0 : 0.70)
                                    }
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ChangeAvatarView(selectedAvatarColor: .blue, selectedAvatarAccessory: .bowtie)
}
