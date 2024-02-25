//
//  QuizSubView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct QuizSubView: View {
    var quiz: quiz
    
    var body: some View {
        HStack {
            Image("blue_dino_great")
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 100)
            VStack (alignment: .leading) {
                Text("test your knowledge for dino points!")
                    .font(.system(size: 14))
                    .bold()
                    .padding(.bottom, 5)
                Text(quiz.question)
                    .font(.system(size: 12))
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
    QuizSubView(quiz: quiz(question: "", answerIndex: 1, choices: []))
}
