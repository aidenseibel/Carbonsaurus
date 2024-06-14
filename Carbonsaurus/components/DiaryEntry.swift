//
//  DiaryEntry.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct DiaryEntry: View {
    @EnvironmentObject var viewModel: ViewModel
    var diary: Diary
    
    @State private var timer: Timer?
    @State var toggleDino: Bool = false
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 5){
                Text("\(formatDate(date: diary.date))")
                    .bold()
                Text("\(diary.dinoPoints())")
                    .bold()
                    .font(.title)
                Text("dino points")
                    .bold()
            }
            Spacer()
            Image(viewModel.localUser.avatar.getImageString())
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
        }
        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
        .frame(width: UIScreen.main.bounds.width * 0.90)
        .background(.white)
        .cornerRadius(10)
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
    DiaryEntry(diary: Diary(date: Date.now, driving: 3, phone: 4, appliances: 3, eat: 3, shower: 3))
        .previewLayout(.sizeThatFits)
}
