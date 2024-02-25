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
                        
                        HStack{
                            ForEach(1...3, id: \.self){_ in
                                Spacer()
                                Image("tree")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 70)
                            }
                            Spacer()
                        }
                        Text("this week")
                            .bold()
                            .font(.system(size: 32))

                        ForEach(localuser.diaries, id: \.self){diary in
                            NavigationLink {
                                DiaryEntryLarge(diary: diary)
                            } label: {
                                DiaryEntry(diary: diary)
                            }
                            .buttonStyle(.plain)
                        }
                    }.padding(.bottom, 100)
                }
                .frame(width: UIScreen.main.bounds.width * 0.90)
            }
            .navigationTitle("diary")
            .navigationBarTitleDisplayMode(.large)

        }
    }
}

#Preview {
    DiaryTab()
}
