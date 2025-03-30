//
//  HistorialView.swift
//  Sympto
//
//  Created by Jordy Granados on 29/03/25.
//

import SwiftUI

struct HistorialView: View {
    var body: some View {
        VStack {
            Text("Historial")
                .font(.largeTitle)
                .padding()
            
            // Add your content for the History screen here
            Image(systemName: "clock.fill")
                .font(.system(size: 100))
                .foregroundColor(.blue)
                .padding()
            
            Text("Tu actividad reciente")
                .font(.title2)
        }
    }
}
