//
//  ShopItemSubView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 7/20/24.
//

import SwiftUI

// overengineered to save needing to make three separate files lol
struct ShopItemSubView: View {
    var shopItem: AvatarItem

    var body: some View {
        VStack(alignment: .leading) {
            Image(shopItem.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: getImageFrame(), height: getImageFrame())
            Text(shopItem.displayName)
                .font(.title2)
                .bold()
                .lineLimit(1)
            Text(String(format: "%.0f", shopItem.dinoPoints) + " dino points")
                .font(.system(size: 12))
                .lineLimit(1)
        }
        .frame(width: getContainerFrameWidth(), height: getContainerFrameHeight())
        .background(.white)
        .cornerRadius(10)
    }

    func getImageFrame() -> Double {
        switch shopItem {
        case is AvatarColor:
            return UIScreen.main.bounds.width * 0.30
        case is AvatarAccessory:
            return UIScreen.main.bounds.width * 0.25
        case is AvatarBackground:
            return UIScreen.main.bounds.width * 0.35
        default:
            return UIScreen.main.bounds.width * 0.35
        }
    }
    
    func getContainerFrameWidth() -> Double {
        switch shopItem {
        case is AvatarColor:
            return UIScreen.main.bounds.width * 0.40
        case is AvatarAccessory:
            return UIScreen.main.bounds.width * 0.35
        case is AvatarBackground:
            return UIScreen.main.bounds.width * 0.45
        default:
            return UIScreen.main.bounds.width * 0.45
        }
    }
    
    func getContainerFrameHeight() -> Double {
        switch shopItem {
        case is AvatarColor:
            return UIScreen.main.bounds.width * 0.50
        case is AvatarAccessory:
            return UIScreen.main.bounds.width * 0.45
        case is AvatarBackground:
            return UIScreen.main.bounds.width * 0.55
        default:
            return UIScreen.main.bounds.width * 0.55
        }
    }
}

#Preview {
    VStack{
        ShopItemSubView(shopItem: AvatarColor.green)
    }
    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    .background(.black)
}
