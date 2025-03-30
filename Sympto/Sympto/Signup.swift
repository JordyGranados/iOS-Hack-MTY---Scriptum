//
//  Signup.swift
//  Sympto
//
//  Created by Alumno on 29/03/25.
//

import SwiftUI

struct Signup: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showDetail = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // Logo or Title
                Text("Sympto")
                    .font(.system(size: 40, weight: .bold))
                    .padding(.bottom, 30)
                    .foregroundColor(.black)
                
                // Form Card
                VStack(alignment: .leading, spacing: 15) {
                    // Email
                    Text("Nombre Completo")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    TextField("Checo Perez Perejil", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)
                    
                    
                    // Email
                    Text("Correo Electrónico")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    TextField("", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)
                    
                    // Password
                    Text("Contraseña")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    SecureField("", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)
                    
                    // Password
                    Text("Confirmar contraseña")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    SecureField("", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)
                    
                    // Signup Text + Button
                    HStack {
                        Text("¿Ya tienes cuenta?")
                            .font(.footnote)
                            .foregroundColor(.black)
                        NavigationLink(destination: ContentView()){
                            Text("Inicia Sesión")
                                .font(.footnote)
                                .foregroundColor(Color(hex: "#4B858D"))
                                .underline()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.top, 5)
                    
                    // Login Button
                    Button(action: {
                        showDetail = true
                    }) {
                        Text("Registrarse")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#FF9A5B"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }
                    .padding(.top, 10)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .background(Color.white.ignoresSafeArea()) // Still white
            .sheet(isPresented: $showDetail) {
                InicioView()
            }
        }
    }
}

#Preview {
    Signup()
}
