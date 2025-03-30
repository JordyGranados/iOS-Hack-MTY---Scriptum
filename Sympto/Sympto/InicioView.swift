//
//  InicioView.swift
//  Sympto
//
//  Created by Jordy Granados on 29/03/25.
//

import SwiftUI

struct InicioView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Encabezado con saludo
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Hola, María")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text("Esperamos que hoy sea un buen día")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color(hex: "#4B858D"))
                }
                .padding(.horizontal)
                .padding(.top)
                
                // Sección de resumen
                VStack(alignment: .leading, spacing: 16) {
                    Text("Tu resumen semanal")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    // Tarjetas de estadísticas
                    VStack(spacing: 12) {
                        // Estadística de dolor
                        StatCard(
                            title: "Nivel de dolor promedio",
                            value: "Moderado",
                            icon: "thermometer.medium",
                            color: .orange,
                            trend: "Similar a la semana pasada"
                        )
                        
                        // Estadística de fatiga
                        StatCard(
                            title: "Días con fatiga",
                            value: "3 de 7",
                            icon: "battery.50",
                            color: .yellow,
                            trend: "Mejor que la semana pasada"
                        )
                        
                        // Estadística de sueño
                        StatCard(
                            title: "Calidad de sueño",
                            value: "Regular",
                            icon: "moon.fill",
                            color: .indigo,
                            trend: "Peor que la semana pasada"
                        )
                    }
                    .padding(.horizontal)
                }
                
                // Sección de síntomas recientes
                VStack(alignment: .leading, spacing: 16) {
                    Text("Síntomas recientes")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            SymptomPill(symptom: "Dolor articular", count: 5, color: .red)
                            SymptomPill(symptom: "Fatiga", count: 3, color: .orange)
                            SymptomPill(symptom: "Rigidez", count: 4, color: .red)
                            SymptomPill(symptom: "Dolor de cabeza", count: 2, color: .green)
                            SymptomPill(symptom: "Sensibilidad", count: 3, color: .green)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 10)
                
                // Sección de registro
                Button(action: {
                    // Acción para registrar síntomas
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                        Text("Registrar síntomas de hoy")
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#4B858D"))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Sección de recursos informativos
                VStack(alignment: .leading, spacing: 16) {
                    Text("Información y recursos")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        InfoResourceCard(
                            title: "Entendiendo la Fibromialgia",
                            source: "Asociación Nacional de Fibromialgia",
                            icon: "doc.text.fill"
                            
                        )
                        
                        InfoResourceCard(
                            title: "Tratamientos recomendados para Lupus",
                            source: "Mayo Clinic",
                            icon: "cross.fill"
                        )
                        
                        InfoResourceCard(
                            title: "Consejos para manejar el dolor crónico",
                            source: "American Pain Society",
                            icon: "heart.text.square.fill"
                        )
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 10)
                .padding(.bottom, 80) // Espacio para la barra de navegación
            }
        }
    }
}

// Componente para tarjetas de estadísticas
struct StatCard: View {
    var title: String
    var value: String
    var icon: String
    var color: Color
    var trend: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(color)
                .frame(width: 45, height: 45)
                .padding(8)
                .background(color.opacity(0.2))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(value)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(trend)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(16)
    }
}

// Componente para píldoras de síntomas
struct SymptomPill: View {
    var symptom: String
    var count: Int
    var color: Color
    
    var body: some View {
        HStack {
            Text(symptom)
                .fontWeight(.medium)
            
            Text("\(count) días")
                .fontWeight(.bold)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background(color.opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(color)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(25)
    }
}

// Componente para tarjetas de recursos informativos
struct InfoResourceCard: View {
    var title: String
    var source: String
    var icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 26))
                .foregroundColor(Color(hex: "#4B858D"))
                .frame(width: 40, height: 40)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(source)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(16)
    }
}

// Preview
struct InicioView_Previews: PreviewProvider {
    static var previews: some View {
        InicioView()
    }
}
