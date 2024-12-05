import SwiftUI

struct PlayerFormView: View {
    var player: Player
    var onSave: (Player) -> Void

    @State private var name: String
    @State private var age: Int
    @State private var email: String
    @State private var country: String
    @State private var position: String
    @State private var playerRole: String
    @State private var currentClub: String

    // Country and Position options
    private let countries = ["United States", "Belgium", "France", "England", "Portugal", "Germany", "Italy", "Spain", "Brazil", "The Netherlands"]
    private let positions = [
        "Goalkeeper", "Right Back", "Left Back", "Attacking Midfielder",
        "Defensive Midfielder", "Center Forward", "Striker", "Central Midfielder",
        "Center Back", "Right Winger", "Left Winger"
    ]

    init(player: Player, onSave: @escaping (Player) -> Void) {
        self.player = player
        self.onSave = onSave
        _name = State(initialValue: player.name)
        _age = State(initialValue: player.age)
        _email = State(initialValue: player.email)
        _country = State(initialValue: player.country)
        _position = State(initialValue: player.position)
        _playerRole = State(initialValue: player.playerRole)
        _currentClub = State(initialValue: player.currentClub)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Basic Information")) {
                    TextField("Name", text: $name)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)

                    Picker("Age", selection: $age) {
                        ForEach(16...99, id: \.self) { age in
                            Text("\(age)").tag(age)
                        }
                    }

                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }

                Section(header: Text("Player Details")) {
                    Picker("Country", selection: $country) {
                        ForEach(countries, id: \.self) { country in
                            Text(country).tag(country)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    Picker("Position", selection: $position) {
                        ForEach(positions, id: \.self) { position in
                            Text(position).tag(position)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    TextField("Player Role", text: $playerRole)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)

                    TextField("Current Club", text: $currentClub)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                }

                Button(action: savePlayer) {
                    Text("Save Player")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(name.isEmpty || email.isEmpty || playerRole.isEmpty || currentClub.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(name.isEmpty || email.isEmpty || playerRole.isEmpty || currentClub.isEmpty)
            }
            .navigationTitle("Player Form")
        }
    }

    private func savePlayer() {
        guard email.contains("@"), email.contains(".") else {
            print("Invalid email format")
            return
        }
        
        let updatedPlayer = Player(
            id: player.id,
            name: name,
            age: age,
            email: email,
            country: country,
            position: position,
            playerRole: playerRole,
            currentClub: currentClub,
            createdBy: player.createdBy
        )
        onSave(updatedPlayer)
    }
}

#Preview {
    PlayerFormView(
        player: Player(
            id: UUID().uuidString,
            name: "New Player",
            age: 20,
            email: "player@example.com",
            country: "Franc",
            position: "Central Midfielder",
            playerRole: "Playmaker",
            currentClub: "Academy FC"
        ),
        onSave: { _ in }
    )
}

