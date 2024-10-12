//
//  QuizView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: ViewModel

    var quiz: Quiz

    @State var hasAnswered = false
    @State var isCorrect = false

    var body: some View {
        ZStack {
            Color.red.opacity(0.30)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text(quiz.question)
                        .font(.title3)
                        .bold()

                    ForEach(quiz.choices, id: \.self) { choice in
                        Button {
                            hasAnswered = true
                            checkAnswer(choice: choice)
                        } label: {
                            HStack {
                                Spacer()
                                if hasAnswered && choice == quiz.choices[quiz.answerIndex] {
                                    Image(systemName: "checkmark")
                                }
                                if hasAnswered && choice != quiz.choices[quiz.answerIndex] {
                                    Image(systemName: "xmark")
                                }
                                Text("\(choice)")
                                Spacer()
                            }
                            .padding(20)
                            .background(.white)
                            .cornerRadius(10)
                        }
                        .disabled(hasAnswered)
                    }

                    if hasAnswered {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack {
                                Spacer()
                                Text("go back to feed")
                                    .bold()
                                    .foregroundColor(.pink.opacity(0.55))
                                    .padding(20)
                                    .background(.white)
                                    .cornerRadius(10)
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.top, 40)
                .frame(width: UIScreen.main.bounds.width * 0.90)
            }
            .frame(width: UIScreen.main.bounds.width * 0.90)
        }
    }

    func checkAnswer(choice: String) {
        if choice == quiz.choices[quiz.answerIndex] {
            isCorrect = true
        } else {
            isCorrect = false
        }
        viewModel.hasAnsweredDailyQuestion = true
        viewModel.localUser.addDailyQuiz(dailyQuiz: DailyQuiz(quiz: quiz, date: Date()))
    }
}

#Preview {
    QuizView(quiz: Quiz(question: "Which of the following greenhouse gases is primarily responsible for the current global warming trend?", answerIndex: 0, choices: ["Carbon dioxide (CO2)", "Methane (CH4)", "Nitrous oxide (N2O)", "Ozone (O3)"]))
}
