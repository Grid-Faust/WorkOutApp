//
//  CreateView.swift
//  WorkOutApp
//
//  Created by Дмитрий Емелин on 03.04.2023.
//

import Foundation
import SwiftUI

struct CreateView: View {
    @StateObject var viewModel = CreateChallangeViewModel()
    
    var dropdownList: some View {
        Group {
            DropdownView(viewModel: $viewModel.exerciseDropdown)
            DropdownView(viewModel: $viewModel.startAmountDropdown)
            DropdownView(viewModel: $viewModel.increaseDropdown)
            DropdownView(viewModel: $viewModel.lenghtDropdown)

        }
//        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
//            DropdownView(viewModel: $viewModel.dropdowns[index])
//        }
        
    }
    
 
    
    var body: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                Button(action: {
                    viewModel.send(action: .createChallenge)
                }) {
                    Text("Create").font(.system(size: 24, weight: .medium))
                        .foregroundColor(.primary)
                }
                
            }
           
            .navigationBarTitle("Create")
            .navigationBarBackButtonHidden(true)
            .padding(.bottom, 15)
            
        } .padding(.bottom, 15)
    }
    
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
        
    }
}
