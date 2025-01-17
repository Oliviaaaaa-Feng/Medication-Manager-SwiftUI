//
//  ContentView.swift
//  MedicationManager
//
//  Created by Olivia on 2025/1/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
                Text("A List Item")
                Text("A Second List Item")
                Text("A Third List Item")
            }
        VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                }
                .padding()
    }
}

#Preview {
    ContentView()
}
