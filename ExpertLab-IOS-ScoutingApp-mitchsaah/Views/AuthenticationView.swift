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
            
            HStack(spacing: 15) {
                Button("Log In") {
                    print("Log In tapped")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                Button("Sign Up") {
                    print("Sign Up tapped")
                }
                .frame(maxWidth: .infinity)
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
    AuthenticationView()
}
