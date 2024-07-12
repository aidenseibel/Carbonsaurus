//
//  ShopView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 5/14/24.
//

import SwiftUI

struct ShopView: View {
    var body: some View {
        ZStack {
            Color.green.opacity(0.30)
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    Grid(alignment: .center, horizontalSpacing: 20, verticalSpacing: 20) {
                        GridRow {
                            Button(action: {
                            }, label: {
                                Image("blue_dino_great")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.width * 0.40)
                                    .cornerRadius(10)
                            })

                            Button(action: {
                            }, label: {
                                Image("green_dino_great")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.width * 0.40)
                                    .cornerRadius(10)
                            })
                        }

                        GridRow {
                            Button(action: {
                            }, label: {
                                Image("pink_dino_great")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.width * 0.40)
                                    .cornerRadius(10)
                            })

                            Button(action: {
                            }, label: {
                                Image("orange_dino_great")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.width * 0.40)
                                    .cornerRadius(10)
                            })
                        }
                        GridRow {
                            Button(action: {
                            }, label: {
                                Image("light_green_dino_great")
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
            .navigationTitle("the shop")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ShopView()
}
