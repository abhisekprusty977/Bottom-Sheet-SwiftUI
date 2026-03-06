//
//  BottomSheet.swift
//  BottomSheetSwiftUI
//
//  Created by Abhisek Prusty on 06/03/26.
//

import SwiftUI

struct BottomSheet<Content: View>: View {
    
    enum SheetPosition: CGFloat, CaseIterable {
        case collapsed = 100
        case medium = 400
        case expanded = 700
    }
    
    @Binding var isPresented: Bool
    @State private var offset: CGFloat = SheetPosition.collapsed.rawValue
    @State private var lastOffset: CGFloat = 0
    
    let content: Content
    
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: () -> Content
    ) {
        self._isPresented = isPresented
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geo in
            
            if isPresented {
                
                ZStack(alignment: .bottom) {
                    
                    // Background Dimming
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            dismiss()
                        }
                    
                    sheetView(height: geo.size.height)
                }
                .animation(.easeInOut(duration: 0.3), value: isPresented)
            }
        }
    }
    
    func sheetView(height: CGFloat) -> some View {
        VStack {
            
            // Drag Indicator
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 40, height: 6)
                .padding(.top, 8)
            
            content
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: height, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
        )
        .offset(y: height - offset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    
                    let newOffset = lastOffset - value.translation.height
                    
                    if newOffset > SheetPosition.collapsed.rawValue &&
                       newOffset < SheetPosition.expanded.rawValue {
                        offset = newOffset
                    }
                }
                .onEnded { value in
                    
                    let predicted = offset - value.predictedEndTranslation.height
                    
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                        offset = nearestPosition(predicted)
                        lastOffset = offset
                    }
                }
        )
        .onAppear {
            withAnimation(.spring()) {
                offset = SheetPosition.medium.rawValue
                lastOffset = offset
            }
        }
    }
    
    func nearestPosition(_ value: CGFloat) -> CGFloat {
        let positions = SheetPosition.allCases.map { $0.rawValue }
        return positions.min(by: { abs($0 - value) < abs($1 - value) }) ?? SheetPosition.medium.rawValue
    }
    
    func dismiss() {
        withAnimation {
            isPresented = false
        }
    }
}
