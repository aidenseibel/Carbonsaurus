//
//  BackgroundShopSubView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 7/19/24.
//

import SwiftUI

struct BackgroundShopSubView: View {
    var background: AvatarBackground

    var body: some View {
        VStack(alignment: .leading) {
            Image(background.rawValue)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.width * 0.35)
            Text(background.name)
                .font(.title2)
                .bold()
                .lineLimit(1)
            Text("\(background.dinoPoints) dino points")
                .font(.system(size: 12))
                .lineLimit(1)
        }
        .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.width * 0.55)
        .background(.white)
        .cornerRadius(10)
    }
}

#Preview {
    VStack{
        BackgroundShopSubView(background: .beach)
    }
    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    .background(.black)
}
