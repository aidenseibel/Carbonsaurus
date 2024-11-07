//
//  HowToGetDinoPointsView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 11/7/24.
//

import SwiftUI

struct HowToGetDinoPointsView: View {
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.40)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 40){
                Text("how do I get dino points?")
                    .font(.system(size: 28))
                    .bold()
                    .padding(.top, 20)

                Text("you can get dino points in two ways: by filling out your diary every day, or by doing the daily quiz.")
                    .font(.system(size: 14))
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("option 1: daily diaries")
                        .font(.system(size: 22))
                        .bold()
                    
                    Text("you can complete a daily diary once per day from the diary tab.")
                        .font(.system(size: 12))
                    
                    DiaryReminderSubView()
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("option 2: daily quizzes")
                        .font(.system(size: 22))
                        .bold()

                    Text("you can answer the daily quiz question from the feed tab")
                        .font(.system(size: 12))

                    QuizSubView()
                }
            }
            .padding()
        }
    }
}

#Preview {
    HowToGetDinoPointsView()
}
