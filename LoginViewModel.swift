import Foundation

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    @Published var sessionKey = ""
    @Published var chequePaymentBankName: BankName?
    @Published var nbfcBrandEmiProviders: [EmiProvider] = []
    @Published var serviceFeeEnabled: Bool = false
    @Published var allowAmountOverride: Bool = false
    @Published var externalRef: String = ""
    @Published var voidAllowed: Bool = false
    @Published var tipEnabled: Bool = false
    @Published var customAppKeys: [(key: String, value: String)] = []

    func login() {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "Username and Password cannot be empty"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        let request = LoginRequest(
            username: username,
            password: password,
            appId: "com.rzp.digiPOS",
            apps: [AppInfo(versionCode: "85", deviceType: "REGULAR_IOS", applicationId: "com.rzp.digiPOS")]
        )
        
        InternetService.shared.login(request: request) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.isLoggedIn = response.success ?? false
                    self.sessionKey = response.sessionKey ?? ""
                    self.chequePaymentBankName = response.setting?.chequePaymentBankNames?.first
                    self.nbfcBrandEmiProviders = response.setting?.nbfcBrandEmiProvider ?? []
                    self.serviceFeeEnabled = response.setting?.serviceFeeEnabled ?? false
                    self.allowAmountOverride = response.setting?.allowAmountOverride ?? false
                    self.externalRef = response.externalRef ?? ""
                    self.voidAllowed = response.voidAllowed
                    self.tipEnabled = response.tipEnabled
                    
                    if let appKeys = response.customAppKeys {
                        self.customAppKeys = appKeys.map { ($0.key, $0.value) }
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
