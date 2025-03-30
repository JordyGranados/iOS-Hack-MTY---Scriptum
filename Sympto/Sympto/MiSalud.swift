//
//  MiSalud.swift
//  Sympto
//
//  Created by Pablo Zapata on 29/03/25.
//
import SwiftUI

struct Sintoma: Identifiable {
    let id = UUID()
    let nombre: String
    var intensidad: String = "N/A"
}

struct MiSalud: View {
    @AppStorage("enfermedad") var enfermedad: String = "Lupus"
    @State private var sintomas: [Sintoma] = []
    @State private var nuevoSintoma: String = ""
    @State private var enfermedadSeleccionada: String = ""

    let niveles = ["N/A", "Muy Baja", "Moderada", "Severa", "Extrema"]
    let enfermedadesDisponibles = ["Lupus", "Fibromialgia"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(spacing: 6) {
                    Text("Mi Salud")
                        .font(.largeTitle.bold())
                        .foregroundColor(.primary)

                    Text("Registro de síntomas – \(Date().formatted(.dateTime.month().day()))")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 8)

                Text("Enfermedad: \(enfermedad)")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .center)

                ForEach(sintomas.indices, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(sintomas[index].nombre)
                            .font(.headline)

                        HStack(spacing: 12) {
                            ForEach(niveles, id: \.self) { nivel in
                                Button(action: {
                                    sintomas[index].intensidad = nivel
                                }) {
                                    Text(nivel)
                                        .font(.caption)
                                        .padding(10)
                                        .frame(minWidth: 45)
                                        .background(sintomas[index].intensidad == nivel ? Color(hex: "#87B9C0") : .gray.opacity(0.2))
                                        .foregroundColor(Color(hex: "#111111"))
                                        .clipShape(Capsule())
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }

                    Divider()
                }

                // Campo para cambiar enfermedad
                VStack(alignment: .leading, spacing: 8) {
                    Text("Buscar enfermedad:")
                        .font(.subheadline)
                    TextField("Escribe aquí (ej. Fibromialgia)", text: $enfermedadSeleccionada)
                        .textFieldStyle(.roundedBorder)
                    Button("Cambiar enfermedad") {
                        if enfermedadesDisponibles.contains(where: { $0.lowercased() == enfermedadSeleccionada.lowercased() }) {
                            enfermedad = enfermedadSeleccionada
                            cargarSintomas()
                            enfermedadSeleccionada = ""
                        }
                    }
                    .foregroundColor(Color(hex: "#4B858D"))
                }

                // Campo para agregar síntoma
                VStack(alignment: .leading, spacing: 8) {
                    Text("¿Tuviste algún otro síntoma hoy?")
                        .font(.subheadline)
                    TextEditor(text: $nuevoSintoma)
                        .frame(height: 30)
                        .padding(10)
                        .background(Color(hex: "#FAFAFA"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.4), lineWidth:1)
                        )
                        .cornerRadius(10)
                        .background(Color (hex: "#FAFAFA"))
                }

                // Botón de guardar
                Button(action: guardarRegistro) {
                    Text("Guardar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#FF9A5B"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top)

                Spacer().frame(height: 100) // Espacio para TabView
            }
            .padding()
        }
        .onAppear(perform: cargarSintomas)
        .navigationTitle("Mi Salud")
    }

    func cargarSintomas() {
        switch enfermedad.lowercased() {
        case "lupus":
            sintomas = [
                Sintoma(nombre: "Nivel de Fatiga Hoy:"),
                Sintoma(nombre: "Nivel de Dolor Articular:"),
                Sintoma(nombre: "Nivel de Fiebre:"),
                Sintoma(nombre: "Nivel de Dolor en el pecho:"),
                Sintoma(nombre: "Nivel de Inflamación en articulaciones:")
            ]
        case "fibromialgia":
            sintomas = [
                Sintoma(nombre: "Nivel de Fatiga Hoy:"),
                Sintoma(nombre: "Nivel de Dolor muscular:"),
                Sintoma(nombre: "Nivel de Niebla mental:"),
                Sintoma(nombre: "Nivel de Insomnio:"),
                Sintoma(nombre: "Nivel de Hipersensibilidad:"),
                Sintoma(nombre: "Nivel de Dolor General:")
            ]
        default:
            sintomas = [Sintoma(nombre: "Síntoma general 1")]
        }
    }

    func guardarRegistro() {
        print("== Registro de síntomas ==")
        for s in sintomas {
            print("- \(s.nombre): \(s.intensidad)")
        }
        if !sintomas.isEmpty {
            print("\nSíntoma adicional reportado: \n\(nuevoSintoma)")
        }
    }
}
#Preview {
    MiSalud()
}

