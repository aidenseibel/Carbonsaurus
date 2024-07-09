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
    var imageURL: String?
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(date)
                    .font(.system(size: 12))
                    .bold()
                    .padding(.bottom, 5)
                Text(title)
                    .font(.system(size: 18))
                
            }
            .padding(10)
            
            Spacer()
            AsyncImage(url: URL(string: imageURL ?? "")) { image in image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray.opacity(0.5))
                    .cornerRadius(10)
            }
        }
        .padding(10)
        .frame(width: UIScreen.main.bounds.width * 0.9)
        .background(Color.white)
        .cornerRadius(10)
    }
}

#Preview {
    NewsComponent(date: "feb 24 - today", title: "United States rejoins the Paris Climate Agreement", imageURL: "blue_dino_happy")
}
