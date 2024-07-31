//
//  AvatarView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 7/31/24.
//

import SwiftUI

struct AvatarView: View {
    @State private var timer: Timer?
    @State var toggleDino: Bool = false

    var avatar: Avatar
    var mood: AvatarMood
    
    var width: Double

    var body: some View {
        ZStack {
            // MARK: BACKGROUND
            if avatar.background == .no_background{
                Circle()
                    .frame(width: width)
                    .foregroundColor(.white)
            }
            else{
                Image(avatar.background.rawValue)
                    .resizable()
                    .frame(width: width, height: width)
                    .scaledToFill()
                    .clipped()
                    .cornerRadius(width * 0.50)
            }
            
            // MARK: DINO
            ZStack {
                Image(toggleDino ? avatar.getImageString(mood: mood) : avatar.getImageStringOneHigher(mood: mood))
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.75, height: width * 0.75)
                    .cornerRadius(50)
                    .clipped()
                
                // MARK: ACCESSORY
                Image(avatar.accessory.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * avatar.accessory.size, height: width * avatar.accessory.size)
                    .rotationEffect(Angle(degrees: avatar.accessory.rotation))
                    .offset(x: width * avatar.accessory.xOffset, y: width * avatar.accessory.yOffset)
            }
            .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
            
        }
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { _ in
                toggleDino.toggle()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

#Preview {
    AvatarView(avatar: Avatar(), mood: AvatarMood.great, width: UIScreen.main.bounds.width)
}
