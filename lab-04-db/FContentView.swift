import SwiftUI

struct FContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View{
        VStack {
            Text("Welcome")
                .font(.title)
                .padding()
            
            Button("Sign out") {
                authViewModel.signOut()
            }
        }
    }
}
