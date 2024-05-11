//
//  QuizSubView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct QuizSubView: View {  
    @EnvironmentObject var viewModel: ViewModel
    @State private var timer: Timer?
    @State var toggleDino: Bool = false

    var body: some View {
        HStack {
            Image("\(viewModel.localUser.getDinoImageString())")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
            VStack (alignment: .leading) {
                Text("test your knowledge for dino points!")
                    .font(.system(size: 18))
                    .bold()
                    .padding(.bottom, 5)
                Text("answer quiz questions correctly to win!")
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
        .onAppear{
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                toggleDino.toggle()
            }
        }
        .onDisappear{
            timer?.invalidate()
        }

    }

}

#Preview {
    QuizSubView()
}
