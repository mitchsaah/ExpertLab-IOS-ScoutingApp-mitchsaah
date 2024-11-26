import SwiftUI

struct AuthenticationView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack (spacing: 20) {
            Text("Sign In")
                .font(.largeTitle)
                .padding()
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    AuthenticationView()
}
