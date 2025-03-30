import SwiftUI

struct RegistroSalud: Identifiable {
    let id = UUID()
    let fecha: Date
    let enfermedad: String
    let sintomas: [Sintoma]
    let notasAdicionales: String?
}

// MARK: - Main Historial View
struct HistorialView: View {
    // Example historial data
    @State private var historial: [RegistroSalud] = [
        RegistroSalud(
            fecha: Date(),
            enfermedad: "Lupus",
            sintomas: [
                Sintoma(nombre: "Fatiga Hoy:", intensidad: "Moderada"),
                Sintoma(nombre: "Dolor Articular:", intensidad: "Muy Baja"),
                Sintoma(nombre: "Fiebre:", intensidad: "N/A"),
                Sintoma(nombre: "Dolor en el pecho:", intensidad: "Severa"),
                Sintoma(nombre: "Inflamación:", intensidad: "Moderada")
            ],
            notasAdicionales: "Sentí más cansancio hoy."
        ),
        
        RegistroSalud(
            fecha: Date(),
            enfermedad: "Lupus",
            sintomas: [
                Sintoma(nombre: "Fatiga Hoy:", intensidad: "Moderada"),
                Sintoma(nombre: "Dolor Articular:", intensidad: "Muy Baja"),
                Sintoma(nombre: "Fiebre:", intensidad: "N/A"),
                Sintoma(nombre: "Dolor en el pecho:", intensidad: "Severa"),
                Sintoma(nombre: "Inflamación:", intensidad: "Moderada")
            ],
            notasAdicionales: "Sentí más cansancio hoy."
        ),
        
        RegistroSalud(
            fecha: Date(),
            enfermedad: "Lupus",
            sintomas: [
                Sintoma(nombre: "Fatiga Hoy:", intensidad: "Moderada"),
                Sintoma(nombre: "Dolor Articular:", intensidad: "Muy Baja"),
                Sintoma(nombre: "Fiebre:", intensidad: "N/A"),
                Sintoma(nombre: "Dolor en el pecho:", intensidad: "Severa"),
                Sintoma(nombre: "Inflamación:", intensidad: "Moderada")
            ],
            notasAdicionales: "Sentí más cansancio hoy."
        )
    ]

    var body: some View {
        NavigationStack {
            VStack {
                profileHeader

                Divider()
                    .padding(.vertical)

                historialList
            }
            .edgesIgnoringSafeArea(.top)
        }
    }

    // MARK: - Profile Header
    private var profileHeader: some View {
        VStack{
            ZStack(alignment: .bottom) {
                // Cover Image (replace with your assets)
                Image("NewYork")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                
                // Profile Image
                Image("OldGuy")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 4))
                    .background(Circle().fill(Color.white))
                    .offset(y: 60)
            }
            .padding(.bottom, 60)
            
            VStack(spacing: 4) {
                Text("Emilio Puga")
                    .font(.system(size: 30, weight: .bold))
                
                Text("📍 Monterrey, MX · 🎂 23 años · ♂️ Masculino")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }

    // MARK: - Historial List
    private var historialList: some View {
        List(historial) { registro in
            NavigationLink(destination: MiSaludHistorialView(registro: registro)) {
                VStack(alignment: .leading) {
                    Text(registro.enfermedad)
                        .font(.headline)
                    Text(registro.fecha.formatted(date: .complete, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Historial de Salud")
    }
}

// MARK: - Static Historial Detail View
struct MiSaludHistorialView: View {
    let registro: RegistroSalud
    let niveles = ["N/A", "Muy Baja", "Moderada", "Severa", "Extrema"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(spacing: 6) {
                    Text("Historial Salud")
                        .font(.largeTitle.bold())

                    Text(registro.fecha.formatted(.dateTime.month().day().year()))
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .center)

                Text("Enfermedad: \(registro.enfermedad)")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .center)

                ForEach(registro.sintomas) { sintoma in
                    VStack(alignment: .leading) {
                        Text(sintoma.nombre)
                            .font(.headline)

                        HStack(spacing: 12) {
                            ForEach(niveles, id: \.self) { nivel in
                                Text(nivel)
                                    .font(.caption)
                                    .padding(10)
                                    .frame(minWidth: 45)
                                    .background(sintoma.intensidad == nivel ? Color(hex: "#87B9C0") : .gray.opacity(0.1))
                                    .foregroundColor(.black)
                                    .clipShape(Capsule())
                                    .opacity(sintoma.intensidad == nivel ? 1.0 : 0.6)
                            }
                        }
                    }
                    .padding(.vertical, 8)

                    Divider()
                }

                if let notas = registro.notasAdicionales, !notas.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notas adicionales:")
                            .font(.headline)
                        Text(notas)
                            .padding()
                            .background(Color(hex: "#FAFAFA"))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Detalle Registro")
    }
}

// MARK: - Preview
#Preview {
    HistorialView()
}
