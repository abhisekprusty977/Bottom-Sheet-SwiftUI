//
//  BottomSheetDetent.swift
//  BottomSheetProductionLevel
//
//  Created by Abhisek Prusty on 06/03/26.
//

import SwiftUI

public enum BottomSheetDetent: Hashable {
    
    case height(CGFloat)
    case fraction(CGFloat)
    case full
    
    func value(in geometry: GeometryProxy) -> CGFloat {
        switch self {
        case .height(let h):
            return h
            
        case .fraction(let f):
            return geometry.size.height * f
            
        case .full:
            return geometry.size.height
        }
    }
}
