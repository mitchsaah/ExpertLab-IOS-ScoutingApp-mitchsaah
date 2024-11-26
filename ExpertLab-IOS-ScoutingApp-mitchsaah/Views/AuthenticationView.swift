import SwiftUI
import FirebaseAuth

struct AuthenticationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoading = false
    
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
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            HStack(spacing: 15) {
                Button("Log In") {
                    logInWithEmail()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                Button("Sign Up") {
                    signUpWithEmail()
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
    
    func logInWithEmail() {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            isLoading = false
            if let error = error {
                errorMessage = "Log In Error: \(error.localizedDescription)"
            } else {
                errorMessage = "Logged in successfully!"
            }
        }
    }
    
    func signUpWithEmail() {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            isLoading = false
            if let error = error {
                errorMessage = "Sign Up Error: \(error.localizedDescription)"
            } else {
                errorMessage = "Account created successfully!"
                email = ""
                password = ""
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
