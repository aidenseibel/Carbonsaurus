//
//  MediumWidgetView.swift
//  Carbonsaurus
//
//  Created by Yash Shah on 7/29/24.
//

import SwiftUI

struct MediumWidgetView: View {
    var viewModel: ViewModel
    
    var body: some View {
        if(viewModel.hasOnboarded && viewModel.hasLoggedToday) {
            HStack {
                AvatarWidgetView(viewModel: viewModel)
                Spacer()
                VStack (spacing: 5) {
                    Text("your dino is")
                        .font(.system(size: 14))
                    Text(viewModel.localUser.getDinoMood().rawValue )
                        .font(.system(size: 32))
                        .bold()
                        .padding(.bottom, 5)
                    Text("\(Int(viewModel.localUser.getDinoPointsThisWeek())) dino points")
                        .font(.system(size: 12))
                    Text(String(format: "%.2f", viewModel.localUser.getCarbonFootprintThisWeek() / 1000) + "kg carbon")
                        .font(.system(size: 12))
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
            }
        }
    }
}

#Preview {
    MediumWidgetView(viewModel: ViewModel())
}
