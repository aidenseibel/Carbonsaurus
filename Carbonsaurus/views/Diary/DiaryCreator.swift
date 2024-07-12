//
//  DiaryCreator.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct DiaryCreator: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: ViewModel

    @State var driving = 3
    @State var phone = 3
    @State var appliances = 3
    @State var eat = 3
    @State var shower = 3

    var options: [Int] = [1, 2, 3, 4, 5]

    var body: some View {
        ZStack {
            Color.purple.opacity(0.25)
                .ignoresSafeArea()
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("new diary entry")
                            .bold()
                            .font(.system(size: 42))

                        Group {
                            VStack(alignment: .leading, spacing: 30) {
                                VStack(alignment: .leading) {
                                    Text("How much did you drive today compared to a normal day?")
                                        .bold()
                                    Picker("driving", selection: $driving) {
                                        ForEach(options, id: \.self) {option in
                                            Text("\(option)")
                                        }
                                    }
                                }

                                VStack(alignment: .leading) {
                                    Text("How much did you use your phone today compared to an average day?")
                                        .bold()
                                    Picker("phone", selection: $phone) {
                                        ForEach(options, id: \.self) {option in
                                            Text("\(option)")
                                        }
                                    }
                                }

                                VStack(alignment: .leading) {
                                    Text("How much did you use large appliances (washer, dryer, oven, etc) compared to a normal day?")
                                        .bold()
                                    Picker("appliances", selection: $appliances) {
                                        ForEach(options, id: \.self) {option in
                                            Text("\(option)")
                                        }
                                    }
                                }

                                VStack(alignment: .leading) {
                                    Text("How much did you eat today compared to a normal day?")
                                        .bold()
                                    Picker("eat", selection: $eat) {
                                        ForEach(options, id: \.self) {option in
                                            Text("\(option)")
                                        }
                                    }
                                }

                                VStack(alignment: .leading) {
                                    Text("How much more did you shower today compared to a normal day?")
                                        .bold()
                                    Picker("shower", selection: $shower) {
                                        ForEach(options, id: \.self) {option in
                                            Text("\(option)")
                                        }
                                    }
                                }
                            }
                        }
                        .pickerStyle(.segmented)

                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.90)

                Button(action: {
                    viewModel.addDiary(diary: Diary(date: Date.now, driving: driving, phone: phone, appliances: appliances, eat: eat, shower: shower))
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Spacer()
                        Text("submit")
                            .bold()
                        Spacer()
                    }
                    .padding(20)
                    .background(.white)
                    .cornerRadius(10)
                })
                .frame(width: UIScreen.main.bounds.width * 0.90)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.isTabBarShowing = false
        }
    }
}

#Preview {
    DiaryCreator()
}
