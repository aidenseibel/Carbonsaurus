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
            Image("blue_dino_great")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
            VStack (alignment: .leading) {
                Text("test your knowledge for dino points!")
                    .font(.system(size: 18))
                    .bold()
                    .padding(.bottom, 5)
                Text("answer this quiz question correctly to win!")
                    .font(.system(size: 14))
                    .bold()
            }.padding(10)
            Spacer()
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
