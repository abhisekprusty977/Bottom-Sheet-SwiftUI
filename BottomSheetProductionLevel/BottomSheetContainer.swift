//
//  BottomSheetContainer.swift
//  BottomSheetProductionLevel
//
//  Created by Abhisek Prusty on 06/03/26.
//

import SwiftUI

struct BottomSheetContainer<Content: View>: View {
    
    @Binding var isPresented: Bool
    let content: Content
    
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: () -> Content
    ) {
        self._isPresented = isPresented
        self.content = content()
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            if isPresented {
                
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
            }
            
            if isPresented {
                content
            }
        }
        .animation(.easeInOut(duration: 0.25), value: isPresented)
    }
}
