//
//  ShopTab.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 5/14/24.
//

import SwiftUI

struct ShopTab: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationStack {
            ZStack {
                Color.yellow.opacity(0.50)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 30) {
                        VStack(alignment: .leading) {
                            Text("dinos")
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack {
                                    ForEach(allAvatarColors, id: \.self){ dino in
                                        if !viewModel.localUser.ownedAvatarColors.contains(dino) {
                                            DinoShopSubView(dino: dino)
                                        }
                                    }
                                }
                            }
                        }

                        VStack(alignment: .leading) {
                            Text("accessories")
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack {
                                    ForEach(allAvatarAccessories, id: \.self){ accessory in
                                        if !viewModel.localUser.ownedAvatarAccessories.contains(accessory) {
                                            AccessoryShopSubView(accessory: accessory)
                                        }
                                    }
                                }
                            }
                        }

                        VStack(alignment: .leading) {
                            Text("backgrounds")
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack {
                                    ForEach(allAvatarBackgrounds, id: \.self){ background in
                                        if !viewModel.localUser.ownedAvatarBackgrounds.contains(background) {
                                            BackgroundShopSubView(background: background)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, UIScreen.main.bounds.width * 0.20)
                }
                .padding()
            }
            .navigationTitle("the dino shop")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ShopTab()
}
