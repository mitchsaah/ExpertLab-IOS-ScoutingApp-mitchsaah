import Foundation

struct Player: Identifiable {
    let id = UUID() // ID of player
    var name: String
    var age: Int
    var country: String
    var position: String
    var playerRole: String
    var currentClub: String
}
