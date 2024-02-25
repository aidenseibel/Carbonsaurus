//
//  QuizView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct QuizView: View {
    var quiz: quiz
    @State var userchoice: Int = 2
    
    var body: some View {
        ZStack {
            Color.red.opacity(0.30)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading, spacing: 20){
                    Text("for 50 dino points!")
                        .font(.title)
                        .bold()
                        .padding(.top, 50)
                    
                    Image("pink_dino_transparent")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.width * 0.25)
                        .clipped()
                        .cornerRadius(10)

                    Text(quiz.question)
                        .font(.title2)
                        .bold()
                    
                    Picker("choices", selection: $userchoice){
                        ForEach(quiz.choices, id: \.self){ choice in
                            Text("\(choice)")
                        }
                    }
                    
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.90)
        }
    }
}

#Preview {
    QuizView(quiz: quiz(question: "Which of the following greenhouse gases is primarily responsible for the current global warming trend?", answerIndex: 1, choices: ["Carbon dioxide (CO2)", "Methane (CH4)", "Nitrous oxide (N2O)", "Ozone (O3)"]))
}
