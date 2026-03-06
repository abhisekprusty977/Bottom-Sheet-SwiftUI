//
//  ContentView.swift
//  BottomSheetProductionLevel
//
//  Created by Abhisek Prusty on 06/03/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSheet = false
    
    var body: some View {
        ZStack {
            Button("Show Sheet") {
                showSheet = true
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .padding()
            
            BottomSheetContainer(isPresented: $showSheet) {
                
                BottomSheetView(
                    isPresented: $showSheet,
                    detents: [
                        .height(120),
                        .fraction(0.4),
                        .fraction(0.75),
                        .full
                    ]
                ) {
                    
                    
                    
                    VStack(spacing: 20) {
                        
                        Text("Production Bottom Sheet")
                            .font(.title.bold())
                        ScrollView {
                            ForEach(0..<30) { i in
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue.opacity(0.1))
                                    .frame(height: 60)
                                    .overlay(
                                        Text("Row \(i)")
                                    )
                            }
                        }
                    }
                    .padding()
                    
                }
            }
            
            
        }
        
    }
}

#Preview {
    ContentView()
}
