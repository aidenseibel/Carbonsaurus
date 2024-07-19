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
    @State var selectedAvatarBackground: AvatarBackground

    var body: some View {
        ZStack {
            Color.yellow.opacity(0.50)
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("cancel")
                        }
                        
                        Spacer()
                        
                        Button {
                            viewModel.updateLocalUserAvatar(avatarColor: selectedAvatarColor, avatarAccessory: selectedAvatarAccessory, avatarBackground: selectedAvatarBackground)
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("save")
                        }
                    }

                    ZStack {
                        if selectedAvatarBackground == .no_background{
                            Circle()
                                .frame(width: UIScreen.main.bounds.width * 0.60)
                                .foregroundColor(.white)
                        } else {
                            Image(selectedAvatarBackground.rawValue)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.60, height: UIScreen.main.bounds.width * 0.60)
                                .scaledToFill()
                                .clipped()
                                .cornerRadius(UIScreen.main.bounds.width * 0.30)
                        }
                        Image("\(selectedAvatarColor)_dino_happy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.width * 0.5)
                            .cornerRadius(50)
                            .clipped()
                    }

                    VStack(alignment: .leading, spacing: 5){
                        Text("choose your dino")
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(viewModel.localUser.ownedAvatarColors, id: \.self) { avatarColor in
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
                                        .background(.white)
                                        .opacity(selectedAvatarColor == avatarColor ? 1.0 : 0.70)
                                    }
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("accessories")
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(viewModel.localUser.ownedAvatarAccessories, id: \.self) { avatarAccessory in
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
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("background")
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(viewModel.localUser.ownedAvatarBackgrounds, id: \.self) { avatarBackground in
                                    ZStack{
                                        Color.black
                                        Button(action: {
                                            selectedAvatarBackground = avatarBackground
                                        }, label: {
                                            Image(avatarBackground.rawValue)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                                        })
                                            .background(.white)
                                            .opacity(selectedAvatarBackground == avatarBackground ? 1.0 : 0.70)
                                    }
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                    Text("check out the dino shop to customize your dino!")
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ChangeAvatarView(selectedAvatarColor: .blue, selectedAvatarAccessory: .bowtie, selectedAvatarBackground: .space)
}
