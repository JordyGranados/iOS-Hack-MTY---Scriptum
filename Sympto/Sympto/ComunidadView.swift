//
//  ComunidadView.swift
//  Sympto
//
//  Created by Jordy Granados on 29/03/25.
//

import SwiftUI

struct ComunidadView: View {
    var body: some View {
        VStack {
            Text("Comunidad")
                .font(.largeTitle)
                .padding()
            
            // Add your content for the Community screen here
            Image(systemName: "person.3.fill")
                .font(.system(size: 100))
                .foregroundColor(.blue)
                .padding()
            
            Text("Conecta con tu comunidad")
                .font(.title2)
        }
    }
}
