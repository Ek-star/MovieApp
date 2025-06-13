import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    // https://console.firebase.google.com/project/movies-app-366p1/authentication/users?hl=id
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.5))

                VStack(alignment: .leading, spacing: 20) {
                    Spacer().frame(height: 60)

                    HStack(spacing: 0) {
                        Text("Movie")
                            .font(.custom("Poppins-ExtraBoldItalic", size: 45))
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                        Text("s")
                            .font(.custom("Poppins-ExtraBoldItalic", size: 45))
                            .foregroundColor(Color(red: 222/255, green: 103/255, blue: 103/255))
                            .shadow(radius: 2)
                    }

                    Text("Create your Account")
                        .font(.custom("Poppins-Medium", size: 20))
                        .foregroundColor(.white)

                    Group {
                        TextField("Email", text: $email)
                            .font(.custom("Poppins-Medium", size: 18))
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)

                        SecureField("Password", text: $password)
                            .font(.custom("Poppins-Medium", size: 18))

                        SecureField("Confirm Password", text: $confirmPassword)
                            .font(.custom("Poppins-Medium", size: 18))
                    }
                    .padding(12)
                    .background(Color(red: 255/255, green: 231/255, blue: 231/255))
                    .cornerRadius(15)
                    .foregroundColor(.black)

                    Spacer()

                    Button(action: handleSignUp) {
                        Text("Sign up")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 45/255, green: 45/255, blue: 45/255))
                            .cornerRadius(15)
                    }
                    .padding(.bottom, 60)

                    NavigationLink(destination: SignInView(), isActive: $navigateToHome) {
                        EmptyView()
                    }
                }
                .padding()
            }
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }

    func handleSignUp() {
        guard !email.isEmpty else {
            alertMessage = "Email is required."
            showAlert = true
            return
        }

        guard password.count >= 6 else {
            alertMessage = "Password must be at least 6 characters."
            showAlert = true
            return
        }

        guard password == confirmPassword else {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.showAlert = true
                return
            }

            DispatchQueue.main.async {
                self.navigateToHome = true
            }
        }
    }
}

// Contoh tampilan setelah berhasil daftar
struct HomeView: View {
    var body: some View {
        Text("Welcome to Home!")
            .font(.largeTitle)
            .bold()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
