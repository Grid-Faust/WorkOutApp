//
//  PrimaryButtonStyle.swift
//  WorkOutApp
//
//  Created by Дмитрий Емелин on 21.03.2023.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var fillColor: Color = .darkPrimaryBurron
    func makeBody(configuration: Configuration) -> some View {
        return PrimaryButton(
            configuration: configuration,
            fillColor: fillColor
        )
    }
    struct PrimaryButton: View {
        let configuration: Configuration
        let fillColor: Color
        var body: some View {
            return configuration.label
                .padding(20)
                .background(
                    RoundedRectangle(
                        cornerRadius: 8
                    ).fill (
                        fillColor
                    )
                )
        }
    }
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Create a challenge")
        }.buttonStyle(PrimaryButtonStyle())
    }
}
