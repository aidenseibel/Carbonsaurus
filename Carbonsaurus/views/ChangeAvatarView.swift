//
//  ChangeAvatarView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct ChangeAvatarView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var timer: Timer?
    @State var index: Int = 0

    var body: some View {
        ZStack {
            Color.yellow.opacity(0.50)
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text("change your avatar")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding(.top, 40)

                    Grid(alignment: .center, horizontalSpacing: 0, verticalSpacing: 20) {
                        ForEach(allAvatarColors, id: \.self) { avatarColor in
                            Button(action: {
                                viewModel.localUser.avatar.color = avatarColor
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image("\(avatarColor.rawValue)_dino_\(getFromIndex())")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.width * 0.35)
                                    .cornerRadius(10)
                            })
                        }
                    }

                    HStack {
                        Text("dino accessories")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.90)
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    index += 1
                    if index > 4 {
                        index = 0
                    }
                }
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
    }

    func getFromIndex() -> String {
        switch index {
        case 0:
            return "great"
        case 1:
            return "happy"
        case 2:
            return "neutral"
        case 3:
            return "worried"
        case 4:
            return "sad"
        default:
            return "happy"
        }
    }
}

#Preview {
    ChangeAvatarView()
}
