//
//  DiaryTab.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct DiaryTab: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var timer: Timer?
    @State var toggleDino: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.blue.opacity(0.30)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading){
                        if !viewModel.hasLoggedToday{
                            NavigationLink {
                                DiaryCreator()
                            } label: {
                                HStack(spacing: 15){
                                    Image("sun")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    VStack(alignment: .leading){
                                        Text("time to check in!")
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
                                .padding(.bottom, 10)
                            }
                            .buttonStyle(.plain)
                        }
                        
                        HStack{
                            ForEach(1...3, id: \.self){_ in
                                Spacer()
                                Image("tree")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 70)
                                    .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                            }
                            Spacer()
                        }
                        Text("this week")
                            .bold()
                            .font(.system(size: 32))

                        ForEach(viewModel.localuser.diaries.sorted { $0.date > $1.date }, id: \.self){diary in
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
    DiaryTab()
}
