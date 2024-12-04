import SwiftUI

struct DashboardView: View {

    var body: some View {
        VStack {
            Text("Welcome to Your Dashboard")
                .font(.largeTitle)
                .padding()
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    DashboardView()
}
