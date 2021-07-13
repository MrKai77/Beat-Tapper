//
//  ContentView.swift
//  BeatTapper
//
//  Created by Kai Azim on 2021-06-30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var BPM:Double = 120
    @State private var difference1:Float = 0
    @State private var difference2:Float = 0
    @State private var currentNum = 1
    @State private var meas1 = -1
    @State private var meas2 = -1
    @State private var meas3 = -1
    @State private var calc1 = -1
    
    let timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Button(action: {
                    difference2 = 60000/difference1
                    BPM = Double(Int(difference2/1000))
                    
                    if(currentNum == 1) {
                        meas1 = Int(BPM)
                        currentNum = 2
                    }
                    else if(currentNum == 2) {
                        meas2 = Int(BPM)
                        currentNum = 3
                    }
                    else if(currentNum == 3) {
                        meas3 = Int(BPM)
                        currentNum = 1
                    }
                    
                    calc1 = meas1 + meas2 + meas3
                    BPM = Double(calc1/3)
                    
                    difference1 = 0
                }, label: {
                    Text("Tap me to find the beat!")
                })
                
                Spacer()
                Text("BPM: \(Int(BPM))")
                Spacer()
            }
        }
        .onReceive(timer) { _ in
            difference1 += 0.001
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
