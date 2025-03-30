import SwiftUI

struct ContentView: View {
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
                    Text("Correo Electrónico")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    TextField("ejemplo@icloud.com", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)

                    // Password
                    Text("Contraseña")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    SecureField("Mi contraseña", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)

                    // Signup Text + Button
                    HStack {
                        Text("¿No tienes cuenta?")
                            .font(.footnote)
                            .foregroundColor(.black)
                        NavigationLink(destination: Signup()) {
                            Text("Regístrate")
                                .font(.footnote)
                                .foregroundColor(Color(hex: "#4B858D"))
                                .underline()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.top, 5)

                    // Login Button
                    NavigationLink(destination: TabBarExampleView()){
                        Text("Iniciar Sesión")
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
            .background(Color.white.ignoresSafeArea())
            .sheet(isPresented: $showDetail) {
                TabBarExampleView()
            }
        }
    }
}

struct DetailView: View {
    var body: some View {
        VStack {
            Text("Bienvenido a Sympto")
                .font(.title)
                .foregroundColor(.black)
                .padding()
        }
        .frame(width: 300, height: 200)
        .background(Color.white)
    }
}

#Preview {
    ContentView()
}
