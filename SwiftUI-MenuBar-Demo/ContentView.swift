//
//  ContentView.swift
//  SwiftUI-MenuBar-Demo
//
//  Created by TAISHIN MIYAMOTO on 2022/05/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Quit") {
                NSApp.terminate(self)
            }
        }
        .frame(width: 200, height: 110)
    }
}
