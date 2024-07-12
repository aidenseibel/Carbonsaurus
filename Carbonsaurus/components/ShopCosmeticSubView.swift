//
//  ShopCosmeticSubView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 5/14/24.
//

import SwiftUI

struct ShopCosmeticSubView: View {
    var accessory: AvatarAccessory

    var body: some View {
        VStack(alignment: .leading) {
            Image(accessory.imageString)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.width * 0.40)
                .cornerRadius(10)
            Text(accessory.name)
                .font(.title3)
                .bold()
            Text("\(accessory.dinoPoints) dino points")
        }
    }
}

#Preview {
    ShopCosmeticSubView(accessory: .banana)
}
