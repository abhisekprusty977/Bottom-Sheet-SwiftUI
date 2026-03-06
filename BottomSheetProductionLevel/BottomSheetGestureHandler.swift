//
//  BottomSheetGestureHandler.swift
//  BottomSheetProductionLevel
//
//  Created by Abhisek Prusty on 06/03/26.
//

import SwiftUI

struct BottomSheetGestureHandler {
    
    static func rubberBand(offset: CGFloat, limit: CGFloat) -> CGFloat {
        
        if offset < 0 {
            return -sqrt(abs(offset)) * 10
        }
        
        if offset > limit {
            return limit + sqrt(offset - limit) * 10
        }
        
        return offset
    }
    
    static func velocitySnap(
        predictedEnd: CGFloat,
        current: CGFloat,
        geometry: GeometryProxy,
        detents: [BottomSheetDetent]
    ) -> CGFloat {
        
        let heights = detents.map { $0.value(in: geometry) }
        
        return heights.min(by: {
            abs($0 - predictedEnd) < abs($1 - predictedEnd)
        }) ?? current
    }
}
