import SwiftUI

// Modelo de usuario
struct Usuario: Identifiable {
    let id = UUID()
    let nombre: String
    let username: String
    let imagenPerfil: String
    let esVerificado: Bool
}

// Modelo de publicación
struct Publicacion: Identifiable {
    let id = UUID()
    let usuario: Usuario
    let contenido: String
    let fecha: String
    let imagenURL: String?
    var megustas: Int
    var comentarios: Int
    var compartidos: Int
    var meGustaActivo: Bool = false
}

// Modelo de tema o etiqueta
struct Tema: Identifiable {
    let id = UUID()
    let nombre: String
    let cantidadPublicaciones: Int
}

struct ComunidadView: View {
    @State private var textoPublicacion = ""
    @State private var mostrarPublicarSheet = false
    @State private var publicaciones: [Publicacion] = datosPublicacionesMuestra
    @State private var temaSeleccionado = "Todos"
    
    // Temas disponibles para filtrar
    let temas = ["Todos", "Fibromialgia", "Lupus", "Tratamientos", "Consejos", "Apoyo"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Encabezado
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Comunidad")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("Conecta con personas que entienden lo que vives")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        // Botón de notificaciones
                        Button(action: {
                            // Acción para ver notificaciones
                        }) {
                            Image(systemName: "bell.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .padding(8)
                                .background(Color.blue.opacity(0.1))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal)
                    
                    // Área para escribir publicación
                    publicarArea
                    
                    // Selector de temas
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(temas, id: \.self) { tema in
                                Button(action: {
                                    temaSeleccionado = tema
                                }) {
                                    Text(tema)
                                        .font(.subheadline)
                                        .fontWeight(temaSeleccionado == tema ? .semibold : .regular)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(temaSeleccionado == tema ? Color.blue : Color.gray.opacity(0.2))
                                        .foregroundColor(temaSeleccionado == tema ? .white : .primary)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    // Sección de tendencias
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Tendencias en la comunidad")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(temasTendencia) { tema in
                            HStack {
                                Text("#\(tema.nombre)")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Text("\(tema.cantidadPublicaciones) publicaciones")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        }
                    }
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Divisor
                    Divider()
                        .padding(.vertical, 8)
                    
                    // Feed de publicaciones
                    VStack(spacing: 16) { // Aumenté el spacing para separar mejor las tarjetas
                        ForEach(publicaciones) { publicacion in
                            PublicacionCard(publicacion: publicacion, accionMeGusta: {
                                if let index = publicaciones.firstIndex(where: { $0.id == publicacion.id }) {
                                    publicaciones[index].meGustaActivo.toggle()
                                    publicaciones[index].megustas += publicaciones[index].meGustaActivo ? 1 : -1
                                }
                            })
                            
                            // Eliminé el Divider porque ya las tarjetas están separadas visualmente
                        }
                    }
                }
                .padding(.bottom, 80) // Espacio para la barra de navegación
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    EmptyView()
                }
            }
        }
        .sheet(isPresented: $mostrarPublicarSheet) {
            publicarView
        }
        .overlay(
            // Botón flotante para crear publicación
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        mostrarPublicarSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Circle().fill(Color.blue))
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 80) // Ajustar para la barra de navegación
                }
            }
        )
        .preferredColorScheme(.light) // Forzar modo claro
    }
    
    // Área para iniciar una publicación
    var publicarArea: some View {
        HStack(spacing: 12) {
            // Avatar del usuario
            Image(systemName: "person.circle.fill")
                .font(.title)
                .foregroundColor(.blue)
            
            // Campo de texto
            Text("¿Qué quieres compartir hoy?")
                .foregroundColor(.gray)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(25)
                .onTapGesture {
                    mostrarPublicarSheet = true
                }
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    // Vista para crear una publicación
    var publicarView: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack(alignment: .top, spacing: 12) {
                    // Avatar del usuario
                    Image(systemName: "person.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                    
                    // Campo de texto
                    TextEditor(text: $textoPublicacion)
                        .placeholder(when: textoPublicacion.isEmpty) {
                            Text("¿Qué estás pensando?")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                        }
                        .frame(minHeight: 150)
                }
                .padding()
                
                Divider()
                
                // Opciones adicionales
                HStack {
                    Button(action: {}) {
                        Label("Foto", systemImage: "photo")
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Label("Encuesta", systemImage: "chart.bar")
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Label("Etiquetas", systemImage: "tag")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Nueva publicación")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        mostrarPublicarSheet = false
                        textoPublicacion = ""
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Publicar") {
                        // Acción para publicar
                        let nuevaPublicacion = Publicacion(
                            usuario: Usuario(
                                nombre: "Tu Nombre",
                                username: "tu_usuario",
                                imagenPerfil: "persona_perfil",
                                esVerificado: false
                            ),
                            contenido: textoPublicacion,
                            fecha: "Ahora",
                            imagenURL: nil,
                            megustas: 0,
                            comentarios: 0,
                            compartidos: 0
                        )
                        publicaciones.insert(nuevaPublicacion, at: 0)
                        mostrarPublicarSheet = false
                        textoPublicacion = ""
                    }
                    .disabled(textoPublicacion.isEmpty)
                    .foregroundColor(textoPublicacion.isEmpty ? .gray : .blue)
                }
            }
        }
        .preferredColorScheme(.light)
    }
}

// Componente de tarjeta de publicación
struct PublicacionCard: View {
    let publicacion: Publicacion
    let accionMeGusta: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Encabezado de la publicación
            HStack {
                // Avatar
                AsyncImage(url: URL(string: publicacion.usuario.imagenPerfil)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                
                // Información del usuario
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(publicacion.usuario.nombre)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        if publicacion.usuario.esVerificado {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.blue)
                                .font(.caption)
                        }
                    }
                    
                    Text("@\(publicacion.usuario.username) • \(publicacion.fecha)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Menú de opciones
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
            }
            
            // Contenido de la publicación
            Text(publicacion.contenido)
                .font(.body)
            
            // Imagen de la publicación (si existe)
            if let imagenURL = publicacion.imagenURL {
                AsyncImage(url: URL(string: imagenURL)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight: 200)
                            .cornerRadius(12)
                    } else if phase.error != nil {
                        Color.gray.opacity(0.3)
                            .frame(height: 160)
                            .cornerRadius(12)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                            )
                    } else {
                        Color.gray.opacity(0.3)
                            .frame(height: 160)
                            .cornerRadius(12)
                            .overlay(
                                ProgressView()
                            )
                    }
                }
            }
            
            // Botones de interacción
            HStack(spacing: 20) {
                // Me gusta
                Button(action: accionMeGusta) {
                    HStack(spacing: 5) {
                        Image(systemName: publicacion.meGustaActivo ? "heart.fill" : "heart")
                            .foregroundColor(publicacion.meGustaActivo ? .red : .gray)
                        
                        Text("\(publicacion.megustas)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                // Comentar
                Button(action: {}) {
                    HStack(spacing: 5) {
                        Image(systemName: "bubble.left")
                            .foregroundColor(.gray)
                        
                        Text("\(publicacion.comentarios)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                // Compartir
                Button(action: {}) {
                    HStack(spacing: 5) {
                        Image(systemName: "arrowshape.turn.up.right")
                            .foregroundColor(.gray)
                        
                        Text("\(publicacion.compartidos)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

// Extensión para TextEditor placeholder
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

// Datos de muestra
let datosPublicacionesMuestra = [
    Publicacion(
        usuario: Usuario(
            nombre: "Laura Martínez",
            username: "laura_fibro",
            imagenPerfil: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=688&auto=format&fit=crop",
            esVerificado: true
        ),
        contenido: "Después de probar el nuevo tratamiento que me recomendó mi reumatólogo, por fin estoy teniendo días buenos otra vez. ¿Alguien más ha probado la terapia con calor húmedo por las mañanas? ¡Está siendo un cambio radical para mí! #Fibromialgia #Tratamientos",
        fecha: "1h",
        imagenURL: nil,
        megustas: 45,
        comentarios: 12,
        compartidos: 3,
        meGustaActivo: false
    ),
    Publicacion(
        usuario: Usuario(
            nombre: "Carlos Vega",
            username: "carlos_lupus",
            imagenPerfil: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=687&auto=format&fit=crop",
            esVerificado: false
        ),
        contenido: "Día difícil hoy. Brote de lupus después de una semana estresante en el trabajo. Recordatorio para mí mismo y todos: ¡el estrés es un gran desencadenante! Necesitamos priorizar el autocuidado incluso cuando estamos ocupados. ¿Qué técnicas usan para manejar el estrés?",
        fecha: "3h",
        imagenURL: nil,
        megustas: 38,
        comentarios: 24,
        compartidos: 7,
        meGustaActivo: false
    ),
    Publicacion(
        usuario: Usuario(
            nombre: "Ana García",
            username: "ana_bienestar",
            imagenPerfil: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop",
            esVerificado: true
        ),
        contenido: "¡Miren lo que preparé hoy! Batido antiinflamatorio con cúrcuma, jengibre y frutas. Ha sido parte de mi rutina diaria durante el último mes y noto menos rigidez por las mañanas. La alimentación marca una gran diferencia. Receta en los comentarios 👇",
        fecha: "5h",
        imagenURL: "https://images.unsplash.com/photo-1623065422902-30a2d299bbe4?q=80&w=2071&auto=format&fit=crop",
        megustas: 122,
        comentarios: 43,
        compartidos: 15,
        meGustaActivo: false
    ),
    Publicacion(
        usuario: Usuario(
            nombre: "Miguel Serrano",
            username: "miguels",
            imagenPerfil: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=2070&auto=format&fit=crop",
            esVerificado: false
        ),
        contenido: "Dos años desde mi diagnóstico de fibromialgia. Ha sido un camino difícil, pero también de mucho aprendizaje. Gracias a esta comunidad por el apoyo constante. Me han ayudado más de lo que imaginan. ¡Seguimos adelante!",
        fecha: "1d",
        imagenURL: nil,
        megustas: 87,
        comentarios: 32,
        compartidos: 5,
        meGustaActivo: false
    ),
    Publicacion(
        usuario: Usuario(
            nombre: "Dra. Sofía Méndez",
            username: "dra_sofia",
            imagenPerfil: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop",
            esVerificado: true
        ),
        contenido: "Recordatorio importante: El lupus puede afectar a cada persona de manera diferente. No minimices tus síntomas por compararte con otros. Tu experiencia es válida y merece atención médica adecuada. Mantén un diario de síntomas para tus citas - ¡es una herramienta muy útil para tu médico!",
        fecha: "2d",
        imagenURL: nil,
        megustas: 211,
        comentarios: 47,
        compartidos: 78,
        meGustaActivo: false
    )
]

// Temas o hashtags tendencia
let temasTendencia = [
    Tema(nombre: "AutocuidadoFibro", cantidadPublicaciones: 324),
    Tema(nombre: "LupusWarriors", cantidadPublicaciones: 287),
    Tema(nombre: "NieblaMental", cantidadPublicaciones: 156),
    Tema(nombre: "DietaAntiinflamatoria", cantidadPublicaciones: 143)
]

struct ComunidadView_Previews: PreviewProvider {
    static var previews: some View {
        ComunidadView()
    }
}
