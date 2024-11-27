import SwiftUI

struct RoleSelectionView: View {
    @State private var selectedRole: String? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Select Your Role")
                    .font(.largeTitle)
                // Scout button
                Button("I am a Scout") {
                    print("Scout role selected")
                    selectedRole = "Scout"
                }
                .padding()
                .background(selectedRole == "Scout" ? Color.blue.opacity(0.5) : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                // Coach button
                Button("I am a Coach") {
                    print("Coach role selected")
                    selectedRole = "Coach"
                }
                .padding()
                .background(selectedRole == "Coach" ? Color.red.opacity(0.5) : Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                // NavigationLink
                if let role = selectedRole {
                    NavigationLink(
                        destination: AuthenticationView(selectedRole: role, isSignUp: true),
                        label: {
                            Text("Proceed")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    )
                }
                
                // Hyperlink for Login
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                                    
                    NavigationLink(destination: AuthenticationView(selectedRole: nil, isSignUp: false)) {
                        Text("Log in")
                            .foregroundColor(.blue)
                            .underline()
                    }
                }
                .padding(.top, 10)
            }
            .padding()
        }
    }
}

#Preview {
    RoleSelectionView()
}
