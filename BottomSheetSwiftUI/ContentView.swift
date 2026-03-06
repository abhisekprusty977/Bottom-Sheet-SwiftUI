//
//  ContentView.swift
//  BottomSheetSwiftUI
//
//  Created by Abhisek Prusty on 06/03/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSheet = false
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 20) {
                
                Text("Main Screen")
                    .font(.largeTitle)
                
                Button("Show Bottom Sheet") {
                    showSheet = true
                }
            }
            
            BottomSheet(isPresented: $showSheet) {
                
                VStack(spacing: 20) {
                    
                    Text("Bottom Sheet")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("This is a fully animated bottom sheet.")
                    ScrollView {
                        ForEach(0..<10) { i in
                            Text("Item \(i)")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
