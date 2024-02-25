//
//  test.swift
//  Carbonsaurus
//
//  Created by Yash Shah on 2/25/24.
//

import SwiftUI
import AVFoundation

struct MeteorView: View {
    @State private var isMoving = false
    var audioPlayer: AVAudioPlayer?
    
    init() {
        if let soundURL = Bundle.main.url(forResource: "explosion", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error loading sound file: \(error.localizedDescription)")
            }
        } else {
            print("Sound file not found")
        }
    }
    var body: some View {
        GeometryReader { geometry in
            GifView(name: "meteor-rock")
                .frame(width: 150, height: 150)
                .position(x: isMoving ? geometry.size.width / 2 : geometry.size.width,
                          y: isMoving ? geometry.size.height : 75)
                .animation(.easeInOut(duration: 1))
            
        }
        .onTapGesture {
            withAnimation {
                isMoving.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    audioPlayer?.play()
                }
            }
        }
    }
}

#Preview {
    MeteorView()
}
