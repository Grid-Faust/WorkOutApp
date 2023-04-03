//
//  ContentView.swift
//  WorkOutApp
//
//  Created by Дмитрий Емелин on 21.03.2023.
//

import SwiftUI

struct LandingView: View {
    @State private var isActive = false
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack{
                    Spacer().frame(height:proxy.size.height * 0.18)
                    Text("WorkOut")
                        .font(.system(size: 64, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink(destination: CreateView(), isActive: $isActive) {
                        Button(action: {
                            isActive = true
                        }) {
                            HStack(spacing: 10) {
                                Spacer()
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                                Text("Create a challenge")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                                Spacer()
                            }.padding(.horizontal,15)
                                
                        }.buttonStyle(PrimaryButtonStyle())
                            .padding(.bottom, 20)
                        
                    }
                }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .background(
                    Image("WorkOut")
                        .resizable()
                        .aspectRatio(
                            contentMode: .fill
                        )
                        .overlay(Color.black.opacity(0.3))
                        .frame(width: proxy.size.width)
                        .edgesIgnoringSafeArea(.all)
                        .ignoresSafeArea()
                )
            }.accentColor(.primary)
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
            .previewDevice("iPhone 8")
        LandingView()
            .previewDevice("iPhone 12")
        LandingView()
            .previewDevice("iPhone 14 Max")
    }
}
