//
//  AvatarView.swift
//  Carbonsaurus
//
//  Created by Yash Shah on 7/29/24.
//

import SwiftUI
import Combine

struct AvatarView: View {
    var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            if viewModel.localUser.avatar.background == AvatarBackground.no_background {
                Circle()
                    .foregroundColor(.white)
            } else {
                Image(viewModel.localUser.avatar.background.rawValue)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .cornerRadius(UIScreen.main.bounds.width * 0.35)
            }
            Image(viewModel.localUser.getAvatarImage())
                .resizable()
                .scaledToFit()
                .cornerRadius(50)
                .clipped()
        }
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
}

#Preview {
    AvatarView(viewModel: ViewModel())
}
