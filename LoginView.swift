import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }
                
                Button("Login") {
                    viewModel.login()
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isLoading)
                
                NavigationLink(destination: HomeView().environmentObject(viewModel), isActive: $viewModel.isLoggedIn) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
}
