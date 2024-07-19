//
//  AccessoryShopSubView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 5/14/24.
//

import SwiftUI

struct AccessoryShopSubView: View {
    var accessory: AvatarAccessory

    var body: some View {
        VStack(alignment: .leading) {
            Image(accessory.rawValue)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
            Text(accessory.name)
                .font(.title2)
                .bold()
                .lineLimit(1)
            Text("\(accessory.dinoPoints) dino points")
                .font(.system(size: 12))
                .lineLimit(1)
        }
        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.width * 0.45)
        .background(.white)
        .cornerRadius(10)
    }
}

#Preview {
    VStack{
        AccessoryShopSubView(accessory: .banana)
    }
    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    .background(.black)
}
