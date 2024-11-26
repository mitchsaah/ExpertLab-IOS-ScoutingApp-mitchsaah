import SwiftUI

struct RoleSelectionView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Select Your Role")
                .font(.largeTitle)
            // Scout button
            Button("I am a Scout") {
                print("Scout role selected")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            // Coach button
            Button("I am a Coach") {
                print("Coach role selected")
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    RoleSelectionView()
}
