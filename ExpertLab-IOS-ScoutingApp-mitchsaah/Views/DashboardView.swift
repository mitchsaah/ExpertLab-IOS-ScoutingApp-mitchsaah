import SwiftUI

struct DashboardView: View {
    let role: String
    @State private var players: [Player] = []
    @State private var showPlayerForm = false
    @State private var selectedPlayer: Player?

    var body: some View {
        VStack {
            Text("Dashboard")
                .font(.largeTitle)
                .padding()
                .multilineTextAlignment(.center)
            
            Text("Role: \(role)")
        }
        .padding()
    }
}

#Preview {
    DashboardView(role:"Scout")
}
