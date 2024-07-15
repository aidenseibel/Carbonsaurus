//
//  DiaryReminderSubView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 7/15/24.
//

import SwiftUI

struct DiaryReminderSubView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Image("panorama")
                .resizable()
                .scaledToFit()
            Text("time to check in!")
                .font(.title2)
                .bold()
            Text("complete your daily report for dino points")
                .font(.system(size: 14))
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

#Preview {
    DiaryReminderSubView()
}
