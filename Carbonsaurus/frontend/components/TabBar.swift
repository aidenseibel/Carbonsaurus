//
//  TabBar.swift
//  Carbonsaurus
//
//  Created by Yash Shah on 2/25/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case profile = "tree.circle.fill"
    case diary = "sun.horizon.fill"
    case shop = "cart.circle.fill"
    case feed = "globe.europe.africa.fill"
}

struct TabBar: View {
    @Binding var selectedTab: Tab

    private var tabColor: Color {
        switch selectedTab {
        case .profile:
            return .green
        case .diary:
            return .blue
        case .shop:
            return .yellow
        case .feed:
            return .orange
        }
    }

    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.5 : 1.0)
                        .foregroundColor(selectedTab == tab ? tabColor : .gray)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.075)
            .background(.white)
            .cornerRadius(50)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .shadow(radius: 10)
        }
    }
}

#Preview {
    TabBar(selectedTab: .constant(.profile))
}
