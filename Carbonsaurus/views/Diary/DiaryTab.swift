//
//  DiaryTab.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct DiaryTab: View {
    @EnvironmentObject var localuser: user
    @State var hasDiaryToday: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.blue.opacity(0.30)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading){
                        Text("diary")
                            .bold()
                            .font(.system(size: 42))
                        

                        if !hasDiaryToday{
                            NavigationLink {
                                DiaryCreator()
                            } label: {
                                HStack(spacing: 15){
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    VStack(alignment: .leading){
                                        Text("time to check in")
                                            .font(.title2)
                                            .bold()
                                        Text("complete your daily report!")
                                            .bold()
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                            }
                        }
                        
                        Text("this week")
                            .bold()
                            .font(.system(size: 3326))

                        ForEach(localuser.diaries, id: \.self){diary in
                            NavigationLink {
                                DiaryEntryLarge(diary: diary)
                            } label: {
                                DiaryEntry(diary: diary)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.90)
            }
        }
    }
}

#Preview {
    DiaryTab()
}
