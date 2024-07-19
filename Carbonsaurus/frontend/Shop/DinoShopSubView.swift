//
//  DinoShopSubview.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 7/19/24.
//

import SwiftUI

struct DinoShopSubView: View {
    var dino: AvatarColor

    var body: some View {
        VStack(alignment: .leading) {
            Image(dino.rawValue+"_dino_happy")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.3)
            Text(dino.rawValue)
                .font(.title2)
                .bold()
                .lineLimit(1)
            Text("\(dino.dinoPoints) dino points")
                .font(.system(size: 12))
                .lineLimit(1)
        }
        .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.5)
        .background(.white)
        .cornerRadius(10)
    }
}

#Preview {
    VStack{
        DinoShopSubView(dino: .green)
    }
    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    .background(.black)
}
