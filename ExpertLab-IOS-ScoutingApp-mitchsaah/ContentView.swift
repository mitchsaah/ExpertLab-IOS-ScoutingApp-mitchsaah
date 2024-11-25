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
                readFromFirestore()
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
    
    // Function to read data from Firestore
    func readFromFirestore() {
        let db = Firestore.firestore()
        let testDoc = db.collection("testCollection").document("testFirebase")

        // Reading data
        testDoc.getDocument { document, error in
            if let error = error {
                print("Error reading Firestore: \(error.localizedDescription)")
            } else if let document = document, document.exists {
                let data = document.data()
                print("Document data: \(data ?? [:])")
            } else {
                print("This document does not exist")
            }
        }
    }
}

#Preview {
    ContentView()
}
