//
//  DiaryEntrySubView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct DiaryEntrySubView: View {
    @EnvironmentObject var viewModel: ViewModel
    var diary: Diary

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("\(formatDate(date: diary.date))")
                HStack(alignment: .bottom) {
                    Text("\(diary.dinoPoints())")
                        .font(.title)
                    Text("dino points")
                        .padding(.bottom, 4)
                }
            }
            Spacer()
            Image(viewModel.localUser.avatar.getImageString())
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 75)
        }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 15))
        .frame(width: UIScreen.main.bounds.width * 0.90)
        .background(.white)
        .cornerRadius(10)
    }
}

#Preview {
    DiaryEntrySubView(diary: Diary(date: Date.now, driving: 3, phone: 4, appliances: 3, eat: 3, shower: 3))
        .previewLayout(.sizeThatFits)
}