//
//  BuyShopItemView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 7/19/24.
//

import SwiftUI

struct BuyShopItemView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var showNotEnoughDinoPoints: Bool = false
    
    var shopItem: AvatarItem
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.40)
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    Image(shopItem.imageName)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.70, height: UIScreen.main.bounds.width * 0.70)

                    Text(getShopItemDescription())

                    Button(action: {
                        // returns success or not
                        if viewModel.localUser.buyShopItem(shopItem: shopItem) {
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            showNotEnoughDinoPoints = true
                        }
                    }, label: {
                        Text("buy for " + String(format: "%.0f", shopItem.dinoPoints) + " dino points")
                            .padding(15)
                            .background(.white)
                            .cornerRadius(10)
                    })
                    
                    if showNotEnoughDinoPoints {
                        Text("you do not have enough dino points!")
                    }
                }
                .padding()
            }
        }
    }
    
    func getShopItemDescription() -> String {
        let shopItemDescriptions: [String] = [
            "looks pretty snazzy",
            "oh yeah, this is epic",
            "try this on!",
            "definitely buy this",
            "kind of a vibe ngl"
        ]

        return shopItemDescriptions.randomElement() ?? "yep!"
    }
}

#Preview {
    BuyShopItemView(shopItem: AvatarColor.green)
}
