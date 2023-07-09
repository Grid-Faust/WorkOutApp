//
//  CreateChallangeViewModel.swift
//  WorkOutApp
//
//  Created by Дмитрий Емелин on 08.04.2023.
//

import Foundation
import SwiftUI
import Combine

typealias UserId = String

final class CreateChallangeViewModel: ObservableObject {

    @Published var exerciseDropdown = ChallengePartViewModel(type: .exercise)
    @Published var startAmountDropdown = ChallengePartViewModel(type: .startAmount)
    @Published var increaseDropdown = ChallengePartViewModel(type: .increase)
    @Published var lenghtDropdown = ChallengePartViewModel(type: .lenght)

    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    enum Action {
        case createChallenge
    }
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func send(action: Action) {
        switch action {
        case .createChallenge:
            currentUserId().sink{ complition in
                switch complition {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    print("CreateChallenge: - complited")
                }
            } receiveValue: { userId in
                print("retrived userID = \(userId)")
            }.store(in: &cancellables)
        }
    }
   
    private func currentUserId() -> AnyPublisher<UserId, Error> {
        print("CreateChallengeViewModel: getting user id")
        return userService.currentUser().flatMap { user -> AnyPublisher<UserId, Error> in
            if let userId = user?.uid {
                print("--- user is logged in ...")
                
                return Just(userId)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                print("--- user is being logged in amomymously")
                
                return self.userService
                    .signInAnonymously()
                    .map{ $0.uid }
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}

extension CreateChallangeViewModel {
    struct ChallengePartViewModel: DropdownItemProtocol {
        var selectedOption: DropdownOption
        
        var options: [DropdownOption]
        
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            selectedOption.formatted
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
            self.selectedOption = options.first!
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
                formatted: rawValue.capitalized
                )
            }
        }
        
        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                formatted: "\(rawValue)"
                )
            }
        }
        
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                formatted: "+\(rawValue)"
                )
            }
        }
        
        enum LenghtOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                formatted: "\(rawValue) days"
                )
            }
        }
    }
}
