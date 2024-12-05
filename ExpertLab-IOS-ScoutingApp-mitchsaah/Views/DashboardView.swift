import SwiftUI

struct DashboardView: View {
    let role: String

    var body: some View {
        VStack {
            Text("Dashboard")
                .font(.largeTitle)
                .padding()
                .multilineTextAlignment(.center)
            
            Text("Role: \(role)")
        }
        .padding()
    }
}

#Preview {
    DashboardView(role:"Scout")
}
