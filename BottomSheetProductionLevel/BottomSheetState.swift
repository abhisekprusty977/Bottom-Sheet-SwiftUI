//
//  BottomSheetState.swift
//  BottomSheetProductionLevel
//
//  Created by Abhisek Prusty on 06/03/26.
//

import SwiftUI
internal import Combine

class BottomSheetState: ObservableObject {
    
    @Published var currentOffset: CGFloat = 0
    @Published var currentDetent: BottomSheetDetent?
    
    var detents: [BottomSheetDetent] = []
    
    func nearestDetent(from value: CGFloat, geometry: GeometryProxy) -> CGFloat {
        
        let heights = detents.map { $0.value(in: geometry) }
        
        return heights.min(by: {
            abs($0 - value) < abs($1 - value)
        }) ?? heights.first ?? 0
    }
}
