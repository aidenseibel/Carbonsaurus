//
//  DiaryCreator.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct DiaryCreatorView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: ViewModel

    @State var driving: Double = 3.0
    @State var energy: Double = 3.0
    @State var eat: Double = 3.0
    @State var water: Double = 3.0
    
    @State var isEditingDriving: Bool = false
    @State var isEditingEnergy: Bool = false
    @State var isEditingEat: Bool = false
    @State var isEditingWater: Bool = false

    var body: some View {
        ZStack {
            Color.purple.opacity(0.25)
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    Group {
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading) {
                                Text("How much did you drive today compared to a normal day?")
                                    .font(.system(size: 16))
                                HStack {
                                    Text("less")
                                        .font(.system(size: 14))
                                    Slider(
                                        value: $driving,
                                        in: 1.0...5.0,
                                        onEditingChanged: { editing in
                                            isEditingDriving = editing
                                        }
                                    )
                                    Text("more")
                                        .font(.system(size: 14))
                                }
                            }

                            VStack(alignment: .leading) {
                                Text("How much electricity did you use today compared to a normal day?")
                                    .font(.system(size: 16))
                                HStack {
                                    Text("less")
                                        .font(.system(size: 14))
                                    Slider(
                                        value: $energy,
                                        in: 1.0...5.0,
                                        onEditingChanged: { editing in
                                            isEditingEnergy = editing
                                        }
                                    )
                                    Text("more")
                                        .font(.system(size: 14))
                                }
                            }

                            VStack(alignment: .leading) {
                                Text("How much did you eat today compared to a normal day?")
                                    .font(.system(size: 16))
                                HStack {
                                    Text("less")
                                        .font(.system(size: 14))
                                    Slider(
                                        value: $eat,
                                        in: 1.0...5.0,
                                        onEditingChanged: { editing in
                                            isEditingEat = editing
                                        }
                                    )
                                    Text("more")
                                        .font(.system(size: 14))
                                }
                            }

                            VStack(alignment: .leading) {
                                Text("How much water did you use today compared to a normal day?")
                                    .font(.system(size: 16))
                                HStack {
                                    Text("less")
                                        .font(.system(size: 14))
                                    Slider(
                                        value: $water,
                                        in: 1.0...5.0,
                                        onEditingChanged: { editing in
                                            isEditingWater = editing
                                        }
                                    )
                                    Text("more")
                                        .font(.system(size: 14))
                                }
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Button(action: {
                        viewModel.addDiary(diary: Diary(date: Date.now, driving: driving, energy: energy, eat: eat, water: water))
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
                    .padding(.bottom, UIScreen.main.bounds.width * 0.20)
                }
                .padding()
            }
            .navigationTitle(formatDateLong(date: Date()))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    DiaryCreatorView()
}
