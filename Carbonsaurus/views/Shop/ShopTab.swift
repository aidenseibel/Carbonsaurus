//
//  ShopTab.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 5/14/24.
//

import SwiftUI

struct ShopTab: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationStack {
            ZStack {
                Color.yellow.opacity(0.50)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text("hello world")
                    }
                }
                .padding()
            }
            .navigationTitle("the dino shop")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ShopTab()
}
