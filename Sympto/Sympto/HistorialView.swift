import SwiftUI

struct HistorialView: View {
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .bottom) {
                    // Cover Image
                    Image("NewYork")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()

                    // Profile Image
                    Image("OldGuy")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 4)
                        )
                        .background(Circle().fill(Color.white))
                        .offset(y: 60)
                }
                .padding(.bottom, 60)

                // Name
                Text("Emilio Puga")
                    .font(.system(size: 40, weight: .bold))
                    .padding(.top, 8)

                // Additional Info
                HStack(spacing: 15) {
                    Text("📍 Monterrey, MX")
                    Text("🎂 23 años")
                    Text("♂️ Masculino")
                }
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 4)

                Divider()
                    .padding(.vertical, 10)

                // Hardcoded "Historial" Title
                Text("Historial")
                    .font(.system(size: 34, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                // Integrated MiSalud View
                MiSalud()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    HistorialView()
}
