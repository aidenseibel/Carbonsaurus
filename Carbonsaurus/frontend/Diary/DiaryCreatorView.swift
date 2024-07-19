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
    @State var phone: Double = 3.0
    @State var appliances: Double = 3.0
    @State var eat: Double = 3.0
    @State var shower: Double = 3.0
    
    @State var isEditingDriving: Bool = false
    @State var isEditingPhone: Bool = false
    @State var isEditingAppliances: Bool = false
    @State var isEditingEat: Bool = false
    @State var isEditingShower: Bool = false

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
                                    .font(.system(size: 14))
                                Slider(
                                    value: $driving,
                                    in: 1.0...5.0,
                                    onEditingChanged: { editing in
                                        isEditingDriving = editing
                                    }
                                )
                            }

                            VStack(alignment: .leading) {
                                Text("How much did you use your phone today compared to a normal day?")
                                    .font(.system(size: 14))
                                Slider(
                                    value: $phone,
                                    in: 1.0...5.0,
                                    onEditingChanged: { editing in
                                        isEditingPhone = editing
                                    }
                                )
                            }

                            VStack(alignment: .leading) {
                                Text("How much did you use large appliances (washer, dryer, oven, etc) compared to a normal day?")
                                    .font(.system(size: 14))
                                Slider(
                                    value: $appliances,
                                    in: 1.0...5.0,
                                    onEditingChanged: { editing in
                                        isEditingAppliances = editing
                                    }
                                )
                            }

                            VStack(alignment: .leading) {
                                Text("How much did you eat today compared to a normal day?")
                                    .font(.system(size: 14))
                                Slider(
                                    value: $eat,
                                    in: 1.0...5.0,
                                    onEditingChanged: { editing in
                                        isEditingEat = editing
                                    }
                                )
                            }

                            VStack(alignment: .leading) {
                                Text("How long did you shower today compared to a normal day?")
                                    .font(.system(size: 14))
                                Slider(
                                    value: $shower,
                                    in: 1.0...5.0,
                                    onEditingChanged: { editing in
                                        isEditingShower = editing
                                    }
                                )
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                    
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
                    .padding(.bottom, UIScreen.main.bounds.width * 0.20)
                }
                .padding()
            }
            .navigationTitle("tuesday, july 16th")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    DiaryCreatorView()
}
