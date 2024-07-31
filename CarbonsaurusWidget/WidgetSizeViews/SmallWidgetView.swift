//
//  SmallWidgetView.swift
//  Carbonsaurus
//
//  Created by Yash Shah on 7/29/24.
//

import SwiftUI

struct SmallWidgetView: View {
    var viewModel: ViewModel
    
    var body: some View {
        AvatarWidgetView(viewModel: viewModel)
    }
}

#Preview {
    SmallWidgetView(viewModel: ViewModel())
}
