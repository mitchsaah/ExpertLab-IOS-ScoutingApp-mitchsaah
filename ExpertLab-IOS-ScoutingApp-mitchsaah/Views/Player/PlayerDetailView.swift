import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct PlayerDetailView: View {
    let player: Player
    @Environment(\.dismiss) private var dismiss
    @State private var isEditing = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Player Image Placeholder
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.blue)
                    .padding()
                    .background(Circle().fill(Color.blue.opacity(0.2)))

                Text(player.name)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.bottom, 5)

                // Player Role
                Text(player.playerRole)
                    .font(.headline)
                    .foregroundColor(.gray)

                Divider()
                    .padding(.vertical, 10)

                // Player Details Section
                VStack(alignment: .leading, spacing: 10) {
                    DetailRow(title: "Age", value: "\(player.age)")
                    DetailRow(title: "Email", value: player.email)
                    DetailRow(title: "Country", value: player.country)
                    DetailRow(title: "Position", value: player.position)
                    DetailRow(title: "Current Club", value: player.currentClub)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                .padding(.horizontal)

                // Action Buttons (Only for Creator)
                if player.createdBy == Auth.auth().currentUser?.email {
                    HStack(spacing: 15) {
                        // Edit Button
                        Button(action: {
                            isEditing = true
                        }) {
                            HStack {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.title3)
                                Text("Edit")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }

                        // Delete Button
                        Button(action: deletePlayer) {
                            HStack {
                                Image(systemName: "trash.circle.fill")
                                    .font(.title3)
                                Text("Delete")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Player Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isEditing) {
            PlayerFormView(
                player: player,
                onSave: { updatedPlayer in
                    savePlayer(updatedPlayer)
                    isEditing = false
                }
            )
        }
    }
    
    private func deletePlayer() {
        let db = Firestore.firestore()
        db.collection("players").document(player.id).delete { error in
            if let error = error {
                print("Error deleting player: \(error.localizedDescription)")
            } else {
                print("Player deleted successfully!")
                dismiss()
            }
        }
    }

    private func savePlayer(_ updatedPlayer: Player) {
        let db = Firestore.firestore()
        do {
            try     db.collection("players").document(updatedPlayer.id).setData(from: updatedPlayer)
                print("Player updated successfully!")
        } catch {
            print("Error updating player: \(error.localizedDescription)")
        }
    }
}

// Helper View for Details Row
struct DetailRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text("\(title):")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.subheadline)
        }
        .padding(.vertical, 5)
    }
}
