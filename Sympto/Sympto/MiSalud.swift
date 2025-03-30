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

                Text("Enfermedad: \(enfermedad.uppercased())")
                    .font(.title3.bold())
                    .foregroundColor(Color(hex: "#111111"))
                    .frame(maxWidth: .infinity, alignment: .center)

                ForEach(sintomas.indices, id: \.self) { index in
                    HStack(alignment: .center) {
                        Text("Nivel de \(sintomas[index].nombre):")
                            .font(.subheadline)
                            .frame(width: 180, alignment: .leading)
                        
                        HStack(spacing:12){
                        Spacer()
                        nivelButtons(for: index)
                        Spacer()
                    }
                    }
                    .padding(.vertical, 8)

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

                // Campo para registrar síntoma adicional libre
                VStack(alignment: .leading, spacing: 8) {
                    Text("¿Tuviste algún otro síntoma hoy?")
                        .font(.subheadline)
                    TextEditor(text: $nuevoSintoma)
                        .frame(height: 20)
                        .padding(10)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                        .cornerRadius(10)
                        .background(Color.white)
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
                .buttonStyle(PlainButtonStyle())

                Spacer().frame(height: 100) // Espacio para TabView
            }
            .padding()
            .background(Color.white) // Fondo blanco para evitar color gris por defecto
        }
        .onAppear(perform: cargarSintomas)
        .background(Color.white) // Fondo blanco total
        .navigationTitle("Mi Salud")
    }

    func nivelButtons(for index: Int) -> some View {
        HStack(spacing: 12) {
            ForEach(niveles, id: \.self) { nivel in
                let isSelected = sintomas[index].intensidad == nivel
                Button(action: {
                    sintomas[index].intensidad = nivel
                }) {
                    Text(nivel)
                        .font(.caption)
                        .padding(10)
                        .frame(minWidth: 45)
                        .background(isSelected ? Color(hex: "#87B9C0") : Color(hex: "#FAFAFA"))
                        .foregroundColor(isSelected ? .white : .black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .clipShape(Capsule())
                }
            }
        }
    }

    func cargarSintomas() {
        switch enfermedad.lowercased() {
        case "lupus":
            sintomas = [
                Sintoma(nombre: "Fatiga Hoy"),
                Sintoma(nombre: "Dolor Articular"),
                Sintoma(nombre: "Fiebre"),
                Sintoma(nombre: "Dolor en el pecho"),
                Sintoma(nombre: "Inflamación en articulaciones")
            ]
        case "fibromialgia":
            sintomas = [
                Sintoma(nombre: "Fatiga Hoy"),
                Sintoma(nombre: "Dolor muscular"),
                Sintoma(nombre: "Niebla mental"),
                Sintoma(nombre: "Insomnio"),
                Sintoma(nombre: "Hipersensibilidad"),
                Sintoma(nombre: "Dolor General")
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
        if !nuevoSintoma.isEmpty {
            print("\nSíntoma adicional reportado:\n\(nuevoSintoma)")
        }
    }
}

#Preview {
    MiSalud()
}

