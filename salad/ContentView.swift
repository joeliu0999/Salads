//
//  ContentView.swift
//  salad
//
//  Created by Liu, Yao Wen on 10/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color(.gray)
            
            VStack {
                
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            
        }

    }
}
struct TopBarView: View {
    var body: some View {
        HStack{
            Text("Salads")
                .font(.headline)
                .foregroundColor(.blue)
            Spacer()
            
        }
    }
}

#Preview {
    ContentView()
}
