//
//  BottomSheetView.swift
//  BottomSheetProductionLevel
//
//  Created by Abhisek Prusty on 06/03/26.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    
    @Binding var isPresented: Bool
    
    let detents: [BottomSheetDetent]
    
    @StateObject private var state = BottomSheetState()
    @StateObject private var keyboard = BottomSheetKeyboardObserver()
    
    @GestureState private var dragOffset: CGFloat = 0
    
    let content: Content
    
    init(
        isPresented: Binding<Bool>,
        detents: [BottomSheetDetent],
        @ViewBuilder content: () -> Content
    ) {
        self._isPresented = isPresented
        self.detents = detents
        self.content = content()
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let maxHeight = detents.map { $0.value(in: geometry) }.max() ?? 0
            
            VStack {
                
                Capsule()
                    .frame(width: 40, height: 6)
                    .foregroundColor(.gray.opacity(0.5))
                    .padding(.top, 8)
                
                content
                    .padding(.bottom, keyboard.keyboardHeight)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: maxHeight)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
            )
            .offset(y: geometry.size.height - state.currentOffset + dragOffset)
            .gesture(dragGesture(geometry: geometry))
            .onAppear {
                
                state.detents = detents
                
                state.currentOffset =
                    detents.first?.value(in: geometry) ?? 300
            }
        }
        .ignoresSafeArea()
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Bottom Sheet")
    }
    
    private func dragGesture(geometry: GeometryProxy) -> some Gesture {
        
        DragGesture()
            .updating($dragOffset) { value, state, _ in
                
                state = value.translation.height * -1
            }
            .onEnded { value in
                
                let predicted =
                state.currentOffset + (-value.predictedEndTranslation.height)
                
                let snap =
                BottomSheetGestureHandler.velocitySnap(
                    predictedEnd: predicted,
                    current: state.currentOffset,
                    geometry: geometry,
                    detents: detents
                )
                
                withAnimation(.interactiveSpring(
                    response: 0.35,
                    dampingFraction: 0.85
                )) {
                    state.currentOffset = snap
                }
            }
    }
}
