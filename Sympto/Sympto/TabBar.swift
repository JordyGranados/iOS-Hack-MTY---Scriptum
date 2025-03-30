// CustomTabBar.swift
import SwiftUI

struct TabItem {
    let icon: String
    let title: String
    let tag: Int
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let items: [TabItem]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { index in
                let item = items[index]
                
                VStack(spacing: 4) {
                    Image(systemName: item.icon)
                        .font(.system(size: 22))
                    
                    Text(item.title)
                        .font(.system(size: 10))
                }
                .foregroundColor(selectedTab == item.tag ? .blue : .gray)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(Color.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        selectedTab = item.tag
                    }
                }
            }
        }
        .frame(height: 60)
        .background(
            Color.white
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)
        )
    }
}

struct TabBarExampleView: View {
    @State private var selectedTab = 0
    
    let tabItems = [
        TabItem(icon: "house", title: "Inicio", tag: 0),
        TabItem(icon: "newspaper", title: "Descubrimientos", tag: 1),
        TabItem(icon: "arrow.up.heart", title: "Mi Salud", tag: 2),
        TabItem(icon: "person.3", title: "Comunidad", tag: 3),
        TabItem(icon: "clock", title: "Historial", tag: 4)
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Content based on selected tab
            Group {
                if selectedTab == 0 {
                    InicioView()
                } else if selectedTab == 1 {
                    DescubrimientosView()
                } else if selectedTab == 2 {
                    MiSalud()
                } else if selectedTab == 3 {
                    ComunidadView()
                } else {
                    HistorialView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Custom navigation bar
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $selectedTab, items: tabItems)
            }
        }
    }
}

#Preview {
    TabBarExampleView()
}
