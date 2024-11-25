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
                writeToFirestore()
            }) {
                Text("Write to Firestore")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }

            // Button to read data FROM Firestore
            Button(action: {
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
    
    // Function to write to Firestore
    func writeToFirestore() {
        let db = Firestore.firestore()
        let testDoc = db.collection("testCollection").document("testFirebase")

        // Writing test data
        testDoc.setData(["testField": "Hello, this is a test!"]) { error in
            if let error = error {
                print("Error writing to Firestore: \(error.localizedDescription)")
            } else {
                print("Data successfully written to Firestore!")
            }
        }
    }
}

#Preview {
    ContentView()
}
