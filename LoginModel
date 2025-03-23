import Foundation

struct LoginRequest: Codable {
    let username: String
    let password: String
    let appId: String
    let apps: [AppInfo]
}

struct AppInfo: Codable {
    let versionCode: String
    let deviceType: String
    let applicationId: String
}

struct LoginResponse: Codable {
    let success: Bool?
    let sessionKey: String?
    let setting: Setting?
    let externalRef: String?
    let voidAllowed: Bool
    let tipEnabled: Bool
    let customAppKeys: [String: String]?
}

struct Setting: Codable {
    let chequePaymentBankNames: [BankName]?
    let nbfcBrandEmiProvider: [EmiProvider]?
    let serviceFeeEnabled: Bool
    let allowAmountOverride: Bool
}

struct BankName: Codable {
    let code: String
    let codeDescription: String
}

struct EmiProvider: Codable {
    let providerName: String
    let displayName: String
}
