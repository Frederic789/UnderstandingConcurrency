//
//  ContentView.swift
//  UnderstandingConcurrency
//
//  Created by Student Account on 11/2/23.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    @State private var progress: Double = 0.0
    @State private var sliderValue: Double = 0.5
    
    var body: some View {
        VStack(spacing: 20) {
            Slider(value: $sliderValue)
            Text("Slider Value: \(sliderValue, specifier: "%.2f")")
            
            Button("Start Long Process") {
                async {
                    await longProcess()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            if progress > 0 {
                ProgressView("Processing", value: progress, total: 1.0)
            }
        }
        .padding()
    }
    
    func longProcess() async {
        for _ in 1...100 {
            try? await Task.sleep(nanoseconds: 100_000_000)
            DispatchQueue.main.async {
                progress += 0.01
            }
        }
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
