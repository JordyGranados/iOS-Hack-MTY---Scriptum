import SwiftUI

// Modelo para representar una noticia
struct Noticia: Identifiable {
    let id = UUID()
    let titulo: String
    let fuente: String
    let fecha: String
    let resumen: String
    let imagenLocal: String?
    let urlArticulo: String
}

struct DescubrimientosView: View {
    
    let noticias = [
        Noticia(
            titulo: "Nuevo tratamiento para la fibromialgia muestra resultados prometedores",
            fuente: "Revista Médica Española",
            fecha: "24 Mar 2025",
            resumen: "Un estudio reciente ha demostrado que un nuevo enfoque terapéutico podría reducir significativamente el dolor en pacientes con fibromialgia.",
            imagenLocal: "tratamiento",
            urlArticulo: "https://ejemplo.com/articulo1"
        ),
        Noticia(
            titulo: "La relación entre el estrés y los brotes de lupus: lo que debes saber",
            fuente: "Fundación de Lupus",
            fecha: "22 Mar 2025",
            resumen: "Investigadores han encontrado nuevas conexiones entre los niveles de estrés y la frecuencia de brotes en pacientes con lupus.",
            imagenLocal: "zen",
            urlArticulo: "https://ejemplo.com/articulo2"
        ),
        Noticia(
            titulo: "Dieta mediterránea podría ayudar a reducir la inflamación en enfermedades autoinmunes",
            fuente: "Nutrición y Salud",
            fecha: "20 Mar 2025",
            resumen: "Un estudio de 5 años sugiere que seguir una dieta mediterránea podría tener efectos antiinflamatorios beneficiosos para pacientes con lupus y fibromialgia.",
            imagenLocal: "meat",
            urlArticulo: "https://ejemplo.com/articulo3"
        ),
        Noticia(
            titulo: "Avances en el diagnóstico temprano de la fibromialgia",
            fuente: "Instituto Nacional de Reumatología",
            fecha: "18 Mar 2025",
            resumen: "Nuevas técnicas de diagnóstico podrían ayudar a identificar la fibromialgia en etapas más tempranas, mejorando el pronóstico a largo plazo.",
            imagenLocal: "lab",
            urlArticulo: "https://ejemplo.com/articulo4"
        ),
        Noticia(
            titulo: "El impacto del ejercicio de baja intensidad en pacientes con dolor crónico",
            fuente: "Revista de Fisioterapia",
            fecha: "15 Mar 2025",
            resumen: "Un programa de ejercicios personalizado de baja intensidad muestra mejoras en la calidad de vida de personas con fibromialgia y lupus.",
            imagenLocal: "ejercicio",
            urlArticulo: "https://ejemplo.com/articulo5"
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Encabezado
                VStack(alignment: .leading, spacing: 8) {
                    Text("Descubrimientos")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Noticias y avances de la semana")
                        .font(.title3)
                        .foregroundColor(Color(hex: "777777"))
                }
                .padding(.horizontal)
                .padding(.top)
                
                // Sección de filtros (opcional)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        FilterChip(title: "Todos", isSelected: true)
                        FilterChip(title: "Fibromialgia", isSelected: false)
                        FilterChip(title: "Lupus", isSelected: false)
                        FilterChip(title: "Tratamientos", isSelected: false)
                        FilterChip(title: "Investigación", isSelected: false)
                    }
                    .padding(.horizontal)
                }
                
                // Lista de noticias
                VStack(spacing: 16) {
                    Text("Noticias de la semana")
                        .font(.title2)
                        .padding(.horizontal)
                    
                    ForEach(noticias) { noticia in
                        NoticiaCard(noticia: noticia)
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 80) // Espacio para la barra de navegación
            }
        }
    }
}

// Componente para representar una tarjeta de noticia
struct NoticiaCard: View {
    let noticia: Noticia
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Imagen de la noticia - ahora maneja tanto imágenes locales como URLs
            if let nombreImagen = noticia.imagenLocal {
                // Imagen local desde Assets
                Image(nombreImagen)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 160)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(12)
            } else {
                // Sin imagen
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 160)
                    .overlay(
                        Image(systemName: "newspaper.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.blue.opacity(0.8))
                    )
                    .cornerRadius(12)
            }
            
            // Información de la noticia
            VStack(alignment: .leading, spacing: 8) {
                // Título
                Text(noticia.titulo)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(2)
                
                // Fuente y fecha
                HStack {
                    Text(noticia.fuente)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Text(noticia.fecha)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                // Resumen
                Text(noticia.resumen)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                // Botón "Leer más"
                Button(action: {
                    // Acción para abrir el artículo completo
                }) {
                    Text("Leer más")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                }
                .padding(.top, 4)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

// Componente para chips de filtro
struct FilterChip: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(isSelected ? .semibold : .regular)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Color(hex: "#87B9C0") : Color.gray.opacity(0.2))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(20)
    }
}

// Vista previa
struct DescubrimientosView_Previews: PreviewProvider {
    static var previews: some View {
        DescubrimientosView()
    }
}
