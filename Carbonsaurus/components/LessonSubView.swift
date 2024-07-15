//
//  LessonSubView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 7/12/24.
//

import SwiftUI

struct LessonSubView: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("take the daily lesson!")
                    .font(.system(size: 18))
                    .bold()
                    .padding(.bottom, 5)
                Text("spend 5 minutes to earn 100 dino points")
                    .font(.system(size: 14))
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
    LessonSubView()
}
