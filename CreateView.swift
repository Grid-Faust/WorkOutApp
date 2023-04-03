//
//  CreateView.swift
//  WorkOutApp
//
//  Created by Дмитрий Емелин on 03.04.2023.
//

import Foundation
import SwiftUI

struct CreateView: View {
    @State private var isActive = false
    
    var body: some View {
        ScrollView {
            VStack {
                DropdownView()
                DropdownView()
                DropdownView()
                DropdownView()
                Spacer()
                NavigationLink(destination: RemindView(), isActive: $isActive) {
                    Button(action: {
                        isActive = true
                    }) {
                        Text("Next").font(.system(size: 24, weight: .medium))
                            .foregroundColor(.primary)
                    }
                }
            }.navigationBarTitle("Create")
                .navigationBarBackButtonHidden(true)
               
        } .padding(.bottom, 15)
    }
    
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
        
    }
}
