import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct DashboardView: View {
    let role: String
    @State private var players: [Player] = []
    @State private var showPlayerForm = false
    @State private var selectedPlayer: Player?
    @State private var isLoading = false
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("Dashboard")
                    .font(.largeTitle)
                    .padding()
                    .multilineTextAlignment(.center)
                
                if isLoading {
                    ProgressView("Loading players...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if players.isEmpty {
                    Text("No players available. Add players to see them.")
                        .foregroundColor(.gray)
                        .padding()
                        .multilineTextAlignment(.center)
                } else {
                    List(players) { player in
                        NavigationLink (
                            destination: PlayerDetailView(player: player)
                        ) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(player.name)
                                        .font(.headline)
                                    Text("\(player.age) | \(player.country)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text(player.positionInitial)
                                    .bold()
                            }
                        }
                    }
                }
                
                // Button for scouts only
                if role == "Scout" {
                    Button(action: {
                        selectedPlayer = nil
                        showPlayerForm = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                            Text("Add Player")
                                .font(.headline)
                        }
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .padding(.top, 10)
                }
            }
            .onAppear {
                fetchPlayersFromFirestore()
            }
            .sheet(isPresented: $showPlayerForm) {
                PlayerFormView(
                    player: selectedPlayer ?? Player(),
                    onSave: { updatedPlayer in
                        if let index = players.firstIndex(where: { $0.id == updatedPlayer.id }) {
                            players[index] = updatedPlayer
                        } else {
                            players.append(updatedPlayer)
                        }
                        savePlayerToFirestore(updatedPlayer)
                        showPlayerForm = false
                    }
                )
            }
        }
    }

    private func fetchPlayersFromFirestore() {
        isLoading = true
        let db = Firestore.firestore()
        db.collection("players").getDocuments { snapshot, error in
            isLoading = false
            if let error = error {
                errorMessage = "Error fetching players: \(error.localizedDescription)"
            } else if let snapshot = snapshot {
                DispatchQueue.main.async {
                    self.players = snapshot.documents.compactMap { try? $0.data(as: Player.self) }
                }
            }
        }
    }
    
    private func savePlayerToFirestore(_ player: Player) {
        let db = Firestore.firestore()
        do {
            try db.collection("players").document(player.id).setData(from: player)
        } catch {
            errorMessage = "Error saving player: \(error.localizedDescription)"
        }
    }
}

extension Player {
    var positionInitial: String {
        switch position.lowercased() {
        case "goalkeeper": return "GK"
        case "right back": return "RB"
        case "left back": return "LB"
        case "attacking midfielder": return "AM"
        case "defensive midfielder": return "DM"
        case "center forward", "striker": return "CF"
        case "central midfielder": return "CM"
        case "center back": return "CB"
        case "right winger": return "RW"
        case "left winger": return "LW"
        default: return "N/A"
        }
    }
}


#Preview {
    DashboardView(role:"Scout")
}
