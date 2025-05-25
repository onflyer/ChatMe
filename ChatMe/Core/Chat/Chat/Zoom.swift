//
//  Zoom.swift
//  ChatMe
//
//  Created by Aleksandar Milidrag on 25. 5. 2025..
//

import SwiftUI

struct ContentView: View {
    @Namespace private var namespace
    
    var body: some View {
        NavigationStack {
            NavigationLink {
                DetailView()
                    .navigationTransition(.zoom(sourceID: "zoom", in: namespace))
            } label: {
                SourceView()
                    .matchedTransitionSource(id: "zoom", in: namespace)
            }
        }
    }
}



struct DetailView: View {
    
    @State var gradientStyle = Gradient(colors: [
        .blue, .purple, .red, .orange, .yellow
    ])
    
    var body: some View {
        
        VStack {
            Image(systemName: "swift")
                .font(.largeTitle)
                .foregroundStyle(.white)
                
                .background {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: gradientStyle,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: 600, height: 200)
                        .ignoresSafeArea()
                }
            
            Spacer()
        }
    }
}
struct SourceView: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.black)
            .frame(width: 250, height: 200)
            
            .overlay {
                Text("Create with Swift")
                    .font(.title)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
            }
    }
    
}

#Preview(body: {
    ContentView()
})
