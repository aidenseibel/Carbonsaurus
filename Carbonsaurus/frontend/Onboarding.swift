//
//  Onboarding.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct Onboarding: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: ViewModel
    @Namespace var questionsID

    @State var driving: String = ""
    @State var energy: String = ""
    @State var eat: String = ""
    @State var water: String = ""

    @State var errorInInputs: Bool = false

    var body: some View {
        ZStack {
            Color.red.opacity(0.30)
                .ignoresSafeArea()

            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        Image("pink_dino_transparent")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.width * 0.25)
                            .clipped()
                            .cornerRadius(10)
                            .padding(.bottom, 30)
                        Text("A few things before we start")
                            .font(.system(size: 48))
                            .bold()
                        Text("We need to collect a few metrics from you so we can get your carbon footpeint accurate.")
                            .bold()
                        Text("You can change these at any time, so don't worry!")
                            .bold()
                            .padding(.bottom, 50)

                        HStack {
                            Button("to the questions!") {
                                withAnimation(.easeInOut(duration: 2.0)) {
                                    proxy.scrollTo(questionsID, anchor: .top)
                                }
                            }
                            .foregroundColor(.pink.opacity(0.55))
                                .buttonStyle(.plain)
                                .padding(20)
                                .bold()
                                .background(.white)
                                .cornerRadius(10)
                                .padding(.bottom, 100)

                            Button("skip for now") {
                                viewModel.localUser.averageDriving = 1
                                viewModel.localUser.averageEnergy = 1
                                viewModel.localUser.averageEating = 1800
                                viewModel.localUser.averageWater = 10
                                DataModel.saveLocalUserToUserDefaults(user: viewModel.localUser)
                                viewModel.hasOnboarded = true
                                presentationMode.wrappedValue.dismiss()
                            }
                            .foregroundColor(.pink.opacity(0.55))
                                .buttonStyle(.plain)
                                .padding(20)
                                .bold()
                                .background(.white)
                                .cornerRadius(10)
                                .padding(.bottom, 100)

                        }

                        Group {
                            VStack(alignment: .leading, spacing: 50) {
                                VStack(alignment: .leading) {
                                    Text("How many hours do you drive on an average day?")
                                        .bold()
                                        .id(questionsID)
                                    TextField("enter hours", text: $driving)
                                        .keyboardType(.numberPad)
                                        .padding(10)
                                        .background(.white)
                                        .cornerRadius(10)
                                }

                                VStack(alignment: .leading) {
                                    Text("How much electricity do you use on an average day?")
                                        .bold()
                                    TextField("enter number of times", text: $energy)
                                        .keyboardType(.numberPad)
                                        .padding(10)
                                        .background(.white)
                                        .cornerRadius(10)
                                }

                                VStack(alignment: .leading) {
                                    Text("How many calories do you eat every day?")
                                        .bold()
                                    TextField("enter calories", text: $eat)
                                        .keyboardType(.numberPad)
                                        .padding(10)
                                        .background(.white)
                                        .cornerRadius(10)
                                }

                                VStack(alignment: .leading) {
                                    Text("How much water do you use on an average day?")
                                        .bold()
                                    TextField("enter minutes", text: $water)
                                        .keyboardType(.numberPad)
                                        .padding(10)
                                        .background(.white)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.bottom, 100)

                        if errorInInputs {
                            Text("Make sure you enter numbers into the text fields!")
                                .bold()
                        }

                        Button(action: {
                            if allFieldsValid() {
                                viewModel.localUser.averageDriving = parseNumber(input: driving)
                                viewModel.localUser.averageEnergy = parseNumber(input: energy)
                                viewModel.localUser.averageEating = parseNumber(input: eat)
                                viewModel.localUser.averageWater = parseNumber(input: water)
                                DataModel.saveLocalUserToUserDefaults(user: viewModel.localUser)
                                viewModel.hasOnboarded = true
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                errorInInputs = true
                            }
                        }, label: {
                            HStack {
                                Spacer()
                                Text("let's go!")
                                    .bold()
                                    .foregroundColor(.pink.opacity(0.55))
                                Spacer()
                            }
                            .padding(20)
                            .background(.white)
                            .cornerRadius(10)
                        })
                        .frame(width: UIScreen.main.bounds.width * 0.90)

                    }
                    .frame(width: UIScreen.main.bounds.width * 0.90)
                    .padding(.top, UIScreen.main.bounds.width * 0.40)
                }
            }
        }
    }

    func allFieldsValid() -> Bool {
        return driving != "" && energy != "" && eat != "" && water != ""
    }
}

#Preview {
    Onboarding()
}
