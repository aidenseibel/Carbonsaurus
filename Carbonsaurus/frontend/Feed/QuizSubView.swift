//
//  QuizSubView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct QuizSubView: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("answer the daily quiz question!")
                    .font(.system(size: 16))
                    .bold()
                    .padding(.bottom, 5)
                Text("test your knowledge, earn 500 dino points")
                    .font(.system(size: 12))
            }.padding(10)
            
            Spacer()
            Image("pink_dino_transparent")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
        }
        .padding(10)
        .frame(width: UIScreen.main.bounds.width * 0.9)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

#Preview {
    QuizSubView()
}
