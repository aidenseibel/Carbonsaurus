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

    // to reload the view when an item is purchased
    @ObservedObject var reloadViewHelper = ReloadViewHelper()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.yellow.opacity(0.40)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 30) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("your balance:")
                                    .font(.system(size: 14))
                                Text(String(format: "%.0f", viewModel.localUser.calculateDinoPointsBalance()) + " dino points")
                                    .font(.title2)
                                    .bold()
                            }
                            Spacer()
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        
                        VStack(alignment: .leading) {
                            Text("dinos")
                                .bold()
                                .font(.system(size: 22))
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack {
                                    ForEach(allAvatarColors, id: \.self){ dino in
                                        if !viewModel.localUser.ownedAvatarColors.contains(dino) {
                                            NavigationLink {
                                                BuyShopItemView(shopItem: dino)
                                                    .onDisappear {
                                                        reloadViewHelper.reloadView()
                                                    }
                                            } label: {
                                                ShopItemSubView(shopItem: dino)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        VStack(alignment: .leading) {
                            Text("accessories")
                                .bold()
                                .font(.system(size: 22))
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack {
                                    ForEach(allAvatarAccessories, id: \.self){ accessory in
                                        if !viewModel.localUser.ownedAvatarAccessories.contains(accessory) {
                                            NavigationLink {
                                                BuyShopItemView(shopItem: accessory)
                                                    .onDisappear {
                                                        reloadViewHelper.reloadView()
                                                    }
                                            } label: {
                                                ShopItemSubView(shopItem: accessory)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        VStack(alignment: .leading) {
                            Text("backgrounds")
                                .bold()
                                .font(.system(size: 22))
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack {
                                    ForEach(allAvatarBackgrounds, id: \.self){ background in
                                        if !viewModel.localUser.ownedAvatarBackgrounds.contains(background) {
                                            NavigationLink {
                                                BuyShopItemView(shopItem: background)
                                                    .onDisappear {
                                                        reloadViewHelper.reloadView()
                                                    }
                                            } label: {
                                                ShopItemSubView(shopItem: background)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, UIScreen.main.bounds.width * 0.20)
                }
            }
            .navigationTitle("the dino shop")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ShopTab()
}
