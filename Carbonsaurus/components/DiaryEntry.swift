//
//  DiaryEntry.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct DiaryEntry: View {
    var diary: diary
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 5){
                Text("\(formatDate(date: diary.date))")
                    .bold()
                Text("\(diary.total * 100)")
                    .bold()
                    .font(.title)
                Text("dino points")
                    .bold()
            }
            Spacer()
            Image("blue_dino_happy")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
        .frame(width: UIScreen.main.bounds.width * 0.90)
        .background(.white)
        .cornerRadius(10)
    }
}

#Preview {
    DiaryEntry(diary: diary(date: Date.now, driving: 3, appliances: 3, eat: 3, shower: 3, total: 15))
        .previewLayout(.sizeThatFits)
}
