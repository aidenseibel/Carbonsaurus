//
//  SettingsView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 7/29/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Color.green.opacity(0.30)
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack {
                    Button {
                        viewModel.resetLocalUser()
                    } label: {
                        Text("reset my profile")
                    }
                }
            }
            .navigationTitle("settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    SettingsView()
}
