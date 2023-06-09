//
//  DropdownView.swift
//  WorkOutApp
//
//  Created by Дмитрий Емелин on 03.04.2023.
//

import Foundation
import SwiftUI

struct DropdownView<T: DropdownItemProtocol>: View {
    
    @Binding var viewModel: T
    
    var actionSheet: ActionSheet {
        ActionSheet(
            title: Text("Select"),
            buttons: viewModel.options.map { option in
                return .default(
                    Text(option.formatted)) {
                        viewModel.selectedOption = option
                    }
            }
        )
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.headerTitle)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }.padding(.vertical, 10)
            Button (action: {
                viewModel.isSelected  = true
            }) {
                HStack {
                    Text(viewModel.dropdownTitle)
                        .font(.system(size: 28, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 22, weight: .medium))

                }
            }.buttonStyle(PrimaryButtonStyle(fillColor: .primaryButton))

        }.padding(15)
            .actionSheet(isPresented: $viewModel.isSelected) {
                actionSheet
            }
    }
    
}

//struct DropdownView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            DropdownView()
//        }
//        NavigationView {
//            DropdownView()
//        }.environment(\.colorScheme, .dark)
//    }
//}
