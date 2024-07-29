//
//  MediumWidgetView.swift
//  Carbonsaurus
//
//  Created by Yash Shah on 7/29/24.
//

import SwiftUI

struct MediumWidgetView: View {
    var viewModel: ViewModel;
    
    var body: some View {
        if(viewModel.hasOnboarded && viewModel.hasLoggedToday) {
            HStack {
                AvatarView(viewModel: viewModel)
                Spacer()
                VStack {
                    Text("\(Int(viewModel.localUser.getDinoPoints() )) Dino Points")
                    Text(viewModel.localUser.getDinoMood().rawValue )
                        .multilineTextAlignment(.center)
                        .font(.system(size: 32))
                        .bold()
                    Text("\(Int(viewModel.localUser.getCarbonFootprintThisWeek() )) kg of carbon this week")
                }
                Spacer()
            }
        } else {
            VStack {
                Image(getRandomPanorama())
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                Text("time to check in!")
            }
        }
    }
}

#Preview {
    MediumWidgetView(viewModel: ViewModel())
}
