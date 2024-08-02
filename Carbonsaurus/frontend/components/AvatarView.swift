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
                    .frame(width: width * (accessoryOffsets[avatar.accessory]?[avatar.color]?.size ?? 0), height: width * (accessoryOffsets[avatar.accessory]?[avatar.color]?.size ?? 0))
                    .rotationEffect(Angle(degrees: (accessoryOffsets[avatar.accessory]?[avatar.color]?.rotation ?? 0)))
                    .offset(x: width * (accessoryOffsets[avatar.accessory]?[avatar.color]?.xOffset ?? 0), y: width * (accessoryOffsets[avatar.accessory]?[avatar.color]?.yOffset ?? 0))
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
    AvatarView(avatar: Avatar(color: .pink, mood: .happy, accessory: .tophat, background: .no_background), mood: AvatarMood.great, width: UIScreen.main.bounds.width)
}
