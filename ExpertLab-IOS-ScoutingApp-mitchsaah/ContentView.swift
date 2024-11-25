import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Firestore test")
                .font(.largeTitle)
                .padding()
            
            // Button to write data TO Firestore
                    Button(action: {
                        // Write function will go here
                    }) {
                        Text("Write to Firestore")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    // Button to read data FROM Firestore
                    Button(action: {
                        // Read function will go here
                    }) {
                        Text("Read from Firestore")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
        .padding()
    }
}

#Preview {
    ContentView()
}
