struct HomeView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Success: \(viewModel.isLoggedIn ? "Yes" : "No")")
            Text("Session Key: \(viewModel.sessionKey)")
            Text("Username: \(viewModel.username)")
                .font(.headline)
            
            if let bank = viewModel.chequePaymentBankName {
                Text("Cheque Payment Bank Name:")
                    .font(.headline)
                Text("\(bank.code): \(bank.codeDescription)")
            }
            
            Text("Service Fee Enabled: \(viewModel.serviceFeeEnabled ? "Yes" : "No")")
            Text("Allow Amount Override: \(viewModel.allowAmountOverride ? "Yes" : "No")")
            
            if !viewModel.nbfcBrandEmiProviders.isEmpty {
                Text("EMI Providers:")
                    .font(.headline)
                ForEach(viewModel.nbfcBrandEmiProviders, id: \.providerName) { provider in
                    Text("\(provider.displayName) (\(provider.providerName))")
                }
            }
            
            Text("External Reference: \(viewModel.externalRef)")
            Text("Void Allowed: \(viewModel.voidAllowed ? "Yes" : "No")")
            Text("Tip Enabled: \(viewModel.tipEnabled ? "Yes" : "No")")
            
            Spacer()
        }
        .padding()
        .navigationTitle("Home")
    }
}
