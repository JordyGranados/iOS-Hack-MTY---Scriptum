//
//  DescubrimientosView.swift
//  Sympto
//
//  Created by Jordy Granados on 29/03/25.
//

// DescubrimientosView.swift
import SwiftUI

struct DescubrimientosView: View {
    var body: some View {
        VStack {
            Text("Descubrimientos")
                .font(.largeTitle)
                .padding()
            
            // Add your content for the Discoveries screen here
            Image(systemName: "newspaper.fill")
                .font(.system(size: 100))
                .foregroundColor(.blue)
                .padding()
            
            Text("Explora nuevos descubrimientos")
                .font(.title2)
        }
    }
}
