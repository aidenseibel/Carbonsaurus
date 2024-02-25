//
//  SkeletonNewsComponent.swift
//  Carbonsaurus
//
//  Created by Yash Shah on 2/24/24.
//

import SwiftUI
import Shimmer

struct SkeletonNewsComponent: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("Placeholder")
                    .font(.system(size: 16))
                    .bold()
                    .padding(.bottom, 5)
                    .redacted(reason: .placeholder)
                    .shimmering()
                
                Text("Lorem ipsum dolor sit amet consectetur adipisicing elit")
                    .font(.system(size: 20))
                    .bold()
                    .redacted(reason: .placeholder)
                    .shimmering()
            }.padding(10)
            Spacer()
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray.opacity(0.5))
                .cornerRadius(10)

        }
        .padding(10)
        .frame(width: UIScreen.main.bounds.width * 0.9)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

#Preview {
    SkeletonNewsComponent()
}
