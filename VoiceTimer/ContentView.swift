import SwiftUI

import Combine

struct VoiceTimeReview: View {
    @State private var remaining: Int = 60
    @State private var isRunning: Bool = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 24) {
            
            Text(formatted(remaining))
                .font(.system(size: 64))
            HStack {
                Button(isRunning ? "Pause" : ".beginTimer") {toggle() }
                    .buttonStyle(.borderedProminent)
                
                Button("Reset") { reset()}
                    .buttonStyle(.borderedProminent)
                    .disabled(isRunning)
            }
        }
    
        .onReceive(timer) { _ in
            if isRunning && remaining > 0 {
                remaining -= 1
            } else if remaining == 0 {
                isRunning = false
            }            }
    }
private func formatted(_ seconds: Int) -> String {
        let m = seconds / 60
    let s = seconds % 60
    return String(format: "%02d:%02d", m, s)
    
    
    }
    private func toggle() {
        isRunning.toggle()
    }
    private func reset() {
        
        remaining = 60; isRunning = false
    }
}
