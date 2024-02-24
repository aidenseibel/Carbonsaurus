//
//  NewsComponent.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct NewsComponent: View {
    var date: String
    var title: String
    var imageTitle: String?
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(date)
                    .font(.system(size: 16))
                    .bold()
                    .padding(.bottom, 5)
                Text (title)
                    .font(.system(size: 20))
                    .bold()
            }.padding(10)
            Spacer()
            Image(imageTitle ?? "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
        }
        .padding(10)
        .frame(width: UIScreen.main.bounds.width * 0.9)
            
            .background(Color.white)
            .cornerRadius(10)
    }
}

#Preview {
    NewsComponent(date: "feb 24 - today", title: "United States rejoins the Paris Climate Agreement", imageTitle: "blue_dino_happy")
}
