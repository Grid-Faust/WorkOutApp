//
//  CreateChallangeViewModel.swift
//  WorkOutApp
//
//  Created by Дмитрий Емелин on 08.04.2023.
//

import Foundation
import SwiftUI

final class CreateChallangeViewModel: ObservableObject {
    @Published var dropdowns: [ChallengePartViewModel] = [
        .init(type: .exercise),
        .init(type: .startAmount),
        .init(type: .increase),
        .init(type: .lenght)
    ]
    
    enum Action {
        case selectOption(index: Int)
    }
    
    var hasSelectedDropdown: Bool {
        selectedDropdownIndex != nil
    }
    var selectedDropdownIndex: Int? {
        dropdowns.enumerated().first(where: { $0.element.isSelected})?.offset
    }
    
    var displayedOptions: [DropdownOption] {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return [] }
        return dropdowns[selectedDropdownIndex].options
    }
    
    func send(action: Action) {
        switch action {
        case let .selectOption(index):
            guard let selectedDropdownIndex = selectedDropdownIndex else { return }
            clearSelectedOptions()
            dropdowns[selectedDropdownIndex].options[index].isSelected = true
            crearSelectedDropdown()
        }
    }
    func clearSelectedOptions() {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return }
        dropdowns[selectedDropdownIndex].options.indices.forEach { index in
            dropdowns[selectedDropdownIndex].options[index].isSelected = false            
        }
    }
    
    func crearSelectedDropdown() {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return }
        dropdowns[selectedDropdownIndex].isSelected = false
    }
}

extension CreateChallangeViewModel {
    struct ChallengePartViewModel: DropdownItemProtocol {
        var options: [DropdownOption]
        
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            options.first(where: { $0.isSelected })?.formatted ?? ""
        }
        
        var isSelected: Bool = false
        private let type: ChallangePartType
        
        init(type: ChallangePartType) {
            switch type {
            case .exercise:
                self.options = ExerciseOption.allCases.map { $0.toDropdownOption }
            case .startAmount:
                self.options = StartOption.allCases.map { $0.toDropdownOption }
            case .increase:
                self.options = IncreaseOption.allCases.map { $0.toDropdownOption }
            case .lenght:
                self.options = LenghtOption.allCases.map { $0.toDropdownOption }
            }
            self.type = type
        }
        
        enum ChallangePartType: String, CaseIterable {
            case exercise = "Exercise"
            case startAmount = "Starting Amount"
            case increase = "Daily Increase"
            case lenght = "Challange Length"
        }
        
        enum ExerciseOption: String, CaseIterable, DropdownOptionProtocol {
            case pullups
            case pushups
            case situps
            
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue),
                      formatted: rawValue.capitalized,
                      isSelected: self == .pullups)
            }
        }
        
        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue)",
                      isSelected: self == .one)
            }
        }
        
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                      formatted: "+\(rawValue)",
                      isSelected: self == .one)
            }
        }
        
        enum LenghtOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue) days",
                      isSelected: self == .seven)
            }
        }
    }
}
