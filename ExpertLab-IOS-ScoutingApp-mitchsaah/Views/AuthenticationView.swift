import SwiftUI
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import FirebaseFirestore

struct AuthenticationView: View {
    let selectedRole: String?
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack (spacing: 20) {
            Text(getLargeTitle())
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Text(getSubtitle())
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
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
                // Log In button
                Button("Log In") {
                    logInWithEmail()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                // Sign Up button
                Button("Sign Up") {
                    signUpWithEmail()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            // Google button
            Button(action: handleGoogleSignIn) {
                HStack {
                    Image("google_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)

                    Text("Sign in with Google")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, minHeight: 44)
                .padding(.horizontal, 20)
                .background(Color(red: 245/255, green: 245/255, blue: 245/255))
                .cornerRadius(8)
            }
        }
        .padding()
    }
    
    func getLargeTitle() -> String {
        guard let role = selectedRole else { return "Welcome!" }
            
        switch role {
        case "Coach":
            return "Welcome, Coach!"
        case "Scout":
            return "Welcome, Scout!"
        default:
            return "Welcome!"
        }
    }
    
    func getSubtitle() -> String {
        guard let role = selectedRole else { return "Sign in to continue." }
            
        switch role {
        case "Coach":
            return "Sign in to discover talent."
        case "Scout":
            return "Sign in to add new players."
        default:
            return "Sign in to continue."
        }
    }
    
    func saveRoleToFirestore(uid: String) {
        guard let role = selectedRole else { return }
           
        let db = Firestore.firestore()
        db.collection("users").document(uid).setData(["role": role]) { error in
            if let error = error {
                errorMessage = "Failed to save role: \(error.localizedDescription)"
            } else {
                print("Role \(role) successfully saved for user \(uid)")
            }
        }
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
            } else if let user = result?.user {
                saveRoleToFirestore(uid: user.uid)
                errorMessage = "Account created successfully!"
                email = ""
                password = ""
            }
        }
    }
    
    func handleGoogleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            errorMessage = "Failed to retrieve client ID."
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        
        // Assign the configuration to GIDSignIn
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
            if let error = error {
                errorMessage = "Google Sign-In Error: \(error.localizedDescription)"
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                errorMessage = "Failed to retrieve Google user or ID token."
                return
            }

            // Processes the ID token for Firebase
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    errorMessage = "Firebase Sign-In Error: \(error.localizedDescription)"
                } else if let user = result?.user {
                    saveRoleToFirestore(uid: user.uid)
                    errorMessage = "Google Sign-In successful!"
                }
            }
        }
    }
    
    // Helper function to retrieve the root view controller
    func getRootViewController() -> UIViewController {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else {
            fatalError("Root view controller not found.")
        }
        return rootVC
    }
}

#Preview {
    AuthenticationView(selectedRole: "Scout") // Example role
}
