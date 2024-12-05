import Foundation

struct Player: Identifiable, Codable {
    let id: String // ID of player
    var name: String
    var age: Int
    var email: String
    var country: String
    var position: String
    var playerRole: String
    var currentClub: String
    var createdBy: String
    
    init(
        id: String = UUID().uuidString,
        name: String = "",
        age: Int = 19,
        email: String = "",
        country: String = "",
        position: String = "",
        playerRole: String = "",
        currentClub: String = "",
        createdBy: String = ""
    ) {
        self.id = id
        self.name = name
        self.age = age
        self.email = email
        self.country = country
        self.position = position
        self.playerRole = playerRole
        self.currentClub = currentClub
        self.createdBy = createdBy
    }
}
