//
//  BottomSheetKeyboardObserver.swift
//  BottomSheetProductionLevel
//
//  Created by Abhisek Prusty on 06/03/26.
//

import SwiftUI
internal import Combine
class BottomSheetKeyboardObserver: ObservableObject {
    
    @Published var keyboardHeight: CGFloat = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        let willShow = NotificationCenter.default.publisher(
            for: UIResponder.keyboardWillShowNotification
        )
        
        let willHide = NotificationCenter.default.publisher(
            for: UIResponder.keyboardWillHideNotification
        )
        
        willShow
            .merge(with: willHide)
            .sink { notification in
                
                if notification.name == UIResponder.keyboardWillShowNotification {
                    
                    if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                        self.keyboardHeight = frame.height
                    }
                } else {
                    self.keyboardHeight = 0
                }
            }
            .store(in: &cancellables)
    }
}

