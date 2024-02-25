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
    
    var quiz: quiz
    
    @State var hasAnswered = false
    @State var isCorrect = false
    
    var body: some View {
        ZStack {
            Color.red.opacity(0.30)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading, spacing: 20){
                    if hasAnswered && !isCorrect{
                        HStack{
                            Spacer()
                            Image("meteor_1")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipped()
                                .cornerRadius(10)
                            Spacer()
                        }
                    }
                    Image("pink_dino_transparent")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.width * 0.25)
                        .clipped()
                        .padding(.top, (hasAnswered && !isCorrect) ? 0: 70)

                    Text(quiz.question)
                        .font(.title2)
                        .bold()
                    
                    ForEach(quiz.choices, id: \.self){choice in
                        Button {
                            checkAnswer(choice: choice)
                        } label: {
                            HStack{
                                Spacer()
                                if hasAnswered && choice == quiz.choices[quiz.answerIndex]{
                                    Image(systemName: "checkmark")
                                }
                                if hasAnswered && choice != quiz.choices[quiz.answerIndex]{
                                    Image(systemName: "xmark")
                                }
                                Text("\(choice)")
                                    .bold()
                                    .foregroundColor(.pink.opacity(0.55))
                                Spacer()
                            }
                            .padding(20)
                            .background(.white)
                            .cornerRadius(10)
                        }
                        .disabled(hasAnswered)
                    }
                    
                    if hasAnswered{
                        Button {
                            if isCorrect{
                                viewModel.localuser.extraDinoPoints = viewModel.localuser.extraDinoPoints + 50
                            }
                            viewModel.isTabBarShowing = true
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack{
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
            .navigationBarBackButtonHidden(true)
            .onAppear{
                viewModel.isTabBarShowing = false
            }
        }
    }
    
    func checkAnswer(choice: String){
        hasAnswered = true
        if choice == quiz.choices[quiz.answerIndex]{
            isCorrect = true
        }else{
            isCorrect = false
        }
    }
}

#Preview {
    QuizView(quiz: quiz(question: "Which of the following greenhouse gases is primarily responsible for the current global warming trend?", answerIndex: 0, choices: ["Carbon dioxide (CO2)", "Methane (CH4)", "Nitrous oxide (N2O)", "Ozone (O3)"]))
}
