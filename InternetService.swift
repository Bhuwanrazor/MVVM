import Alamofire

class InternetService {
    static let shared = InternetService()
    private init() {}
    
    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let url = "https://dev7.ezetap.com/api/2.0/auth/login"
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: request, encoder: JSONParameterEncoder.default, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                        completion(.success(decodedResponse))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
