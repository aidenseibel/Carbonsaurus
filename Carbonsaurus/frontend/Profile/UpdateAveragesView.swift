//
//  UpdateAveragesView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 5/14/24.
//

import SwiftUI

struct UpdateAveragesView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var driving: String = ""
    @State var appliances: String = ""
    @State var eat: String = ""
    @State var water: String = ""

    var body: some View {
        ZStack {
            Color.red.opacity(0.30)
                .ignoresSafeArea()

            ScrollView {
                VStack {
                    Group {
                        VStack(alignment: .leading, spacing: 50) {
                            VStack(alignment: .leading) {
                                Text("How many hours do you drive on an average day?")
                                    .bold()
                                TextField("enter hours", text: $driving)
                                    .keyboardType(.numberPad)
                                    .padding(10)
                                    .background(.white)
                                    .cornerRadius(10)
                            }

                            VStack(alignment: .leading) {
                                Text("How often do you use large appliances (washer, dryer, oven, etc) on any given day?")
                                    .bold()
                                TextField("enter number of times", text: $appliances)
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

                    Button(action: {
                        if isValid(driving) { viewModel.localUser.averageDriving = parseNumber(input: driving) }
                        if isValid(appliances) { viewModel.localUser.averageEnergy = parseNumber(input: appliances) }
                        if isValid(eat) { viewModel.localUser.averageEating = parseNumber(input: eat) }
                        if isValid(water) { viewModel.localUser.averageWater = parseNumber(input: water) }

                        if DataModel.saveLocalUser(user: viewModel.localUser) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }, label: {
                        HStack {
                            Spacer()
                            Text("save")
                                .bold()
                                .foregroundColor(.pink.opacity(0.55))
                            Spacer()
                        }
                        .padding(20)
                        .background(.white)
                        .cornerRadius(10)
                    })
                    .padding(.bottom, 100)
                }
                .padding()
            }
        }
    }

    func isValid(_ str: String) -> Bool {
        // Check if the string is empty
        guard !str.isEmpty else {
            return true
        }

        // Check if all characters are digits
        let characterSet = CharacterSet.decimalDigits
        let isAllDigits = str.unicodeScalars.allSatisfy { characterSet.contains($0) }

        return isAllDigits
    }

}

#Preview {
    UpdateAveragesView()
}
