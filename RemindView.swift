//
//  RemindView.swift
//  WorkOutApp
//
//  Created by Дмитрий Емелин on 03.04.2023.
//

import Foundation
import SwiftUI

struct RemindView: View {
    
    var body: some View {
        VStack {
            Spacer()
            //DropdownView()
            Spacer()
            Button(action: {}) {
                Text("Next").font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }.padding(.bottom, 15)
            Button(action: {}) {
                Text("Skip").font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)

            }
        }.navigationTitle("Remind")
            .padding(.bottom, 15)
    }
    
}

struct RemindView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RemindView()
        }
    }
}
