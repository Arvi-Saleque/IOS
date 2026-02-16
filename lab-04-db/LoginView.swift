import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()

    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            if viewModel.isSignedIn {
                FContentView().environmentObject(viewModel)
            } else {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                HStack {
                    Button("Sign In") {
                        viewModel.signIn(email: email, password: password)
                    }
                    Button("Sign Up") {
                        viewModel.signUp(email: email, password: password)
                    }
                }
            }
        }
        .padding()
    }
}
