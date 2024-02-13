
import Foundation

/*
 Simple API Solution based on NSURLSession
 */
public class Pigeon {

    // MARK: - Constants
    private static let requestWithFileTimeout = 240
    public static let timeout = 30

    // MARK: - Types
    public typealias Success = (_ data: Data) -> Void
    public typealias Failure = (_ error: ApiError) -> Void
    public typealias Unauthenicated = () -> Void

    // MARK: - Singleton
    public static let shared = Pigeon()

    // MARK: - Public Properties
    public var unauthenticatedCallBack: Unauthenicated?
    public var loggingEnabled = true
    public var authToken: String?
    public var anonymousKey: String?
    public var host: String?
    public var additionalHeaders: [String: String] = [: ]

    // MARK: - Headers
    private static func headers() -> [String: String] {
        var headers: [String: String] = [:]
        if let token = Pigeon.shared.authToken {
            headers["authorization"] = "Bearer \(token)"
        } else if let key = Pigeon.shared.anonymousKey {
            headers["Anonymous-Key"] = "\(key)"
        }
        headers["Content-Type"] = "application/json; charset=utf-8"
        headers["Accept"] = "application/json; charset=utf-8"

        for (key, value) in Pigeon.shared.additionalHeaders {
            headers[key] = value
        }

        return headers
    }

    // MARK: - Request
    public static func generateRequest(
        method: Method,
        endpoint: String,
        parameters: [String: Any] = [: ],
        pathParameters: [String: Any] = [: ],
        file: Data? = nil,
        timeout: Int = Pigeon.timeout
    ) -> URLRequest? {

        var url = endpoint
        for (key, value) in pathParameters {
            if url.contains("{\(key)}") {
                url = url.replacingOccurrences(of: "{\(key)}", with: "\(value)")
            } else {
                log("\(url) does not contain provided path parameters of \(key)")
                return nil
            }
        }

        guard let validUrl = URL(string: url) else {
            log("Provided endpoint invalid")
            return nil
        }

        // Construct Request
        var request = URLRequest(url: validUrl)
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(timeout)

        // Add Paramaters
        if (method == .post || method == .patch) {
            if let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                request.httpBody = httpBody
            }
        }

        // Apply Headers
        for (key, value) in headers() {
            request.addValue(value, forHTTPHeaderField: key)
        }

        // Change request type and header if file is include in request.
        if let file = file {
            let boundary = Pigeon.shared.generateBoundaryString()
            request.httpBody = Pigeon.shared.createBodyWithParameters(
                parameters: parameters,
                filePath: "file",
                imageData: file,
                boundary: boundary)
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            // Increase timeout for request with file attachments.
            request.timeoutInterval = TimeInterval(Pigeon.requestWithFileTimeout)
        }

        log("Requesting - \(validUrl.absoluteString)")

        return request
    }

    public static func request(
        method: Method,
        endpoint: String,
        parameters: [String: Any] = [: ],
        pathParameters: [String: Any] = [: ],
        file: Data? = nil,
        timeout: Int = Pigeon.timeout,
        success: @escaping Success,
        failure: @escaping Failure) {

        guard let request = Pigeon.generateRequest(
            method: method,
            endpoint: endpoint,
            parameters: parameters,
            pathParameters: pathParameters,
            file: file,
            timeout: timeout
        )
        else {
            return fail(error: "Invalid Request", code: 400, failure: failure)
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                // Gaurd against empty response
                if let error = error as? NSError {
                    if error.domain == "kCFErrorDomainCFNetwork" {
                        return fail(error: "Unable to establish connection", code: 400, failure: failure)
                    }
                    return fail(error: error.localizedDescription, code: 400, failure: failure)
                }
                
                guard let response = response as? HTTPURLResponse else {
                    return fail(error: String(describing: error), code: 400, failure: failure)
                }

                guard let data = data else {
                    return fail(error: String(describing: error), code: 400, failure: failure)
                }

                guard error == nil else {
                    return fail(error: String(describing: error), code: 400, failure: failure)
                }

                // Inform the client the response has returned as 'Unauthenticated'
                if response.statusCode == 401 {
                    if let callBack = Pigeon.shared.unauthenticatedCallBack {
                        log("Unauthenticated")
                        callBack()
                    }
                }

                // Gaurd against unsuccessful status codes
                guard response.statusCode >= 200 && response.statusCode < 300 else {
                    do {
                        let errorResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        
                        guard let message = errorResponse?["message"] as? String else {
                            return fail(error: "Something went wrong", code: response.statusCode, failure: failure)
                        }
                        
                        if let validationIssues = errorResponse?["errors"] as? [String: [String]] {
                            return fail(error: message, code: response.statusCode, validationIssues: validationIssues, failure: failure)
                        }
                        
                        return fail(error: message, code: response.statusCode, failure: failure)
                    } catch {
                        return fail(error: String(describing: error), code: response.statusCode, failure: failure)
                    }
                }

                // Return success
                success(data)
            }
        }.resume()
    }

    // Convenience method for using the endpoints defined as an Enum
    public static func request(
        method: Method,
        endpoint: Endpoint,
        parameters: [String: Any] = [: ],
        pathParameters: [String: Any] = [: ],
        file: Data? = nil,
        timeout: Int = Pigeon.timeout,
        success: @escaping Success,
        failure: @escaping Failure) {

        Pigeon.request(
            method: method,
            endpoint: endpoint.url(),
            parameters: parameters,
            pathParameters: pathParameters,
            file: file,
            timeout: timeout,
            success: success,
            failure: failure
        )
    }

    // MARK: - Fail with validation errors
    static func fail(error: String, code: Int, validationIssues: [String: [String]], failure: @escaping Failure) {
        let error = ApiError(message: error, code: code, validationIssues: validationIssues)
        if Pigeon.shared.loggingEnabled {
            print("🐣 Failure - code: (\(error.code)) \(error.message) \(String(describing: error.validationIssues)) ")
        }
        failure(error)
    }
    
    // MARK: - Standard Fail
    static func fail(error: String, code: Int, failure: @escaping Failure) {
        let error = ApiError(message: error, code: code)
        if Pigeon.shared.loggingEnabled {
            print("🐣 Failure - code: (\(error.code)) \(error.message) ")
        }
        failure(error)
    }

    // MARK: - Logging
    static func log(_ message: String) {
        if Pigeon.shared.loggingEnabled {
            print("🐦 \(message)")
        }
    }

    // MARK: - Multipart Data
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }

    func createBodyWithParameters(parameters: [String: Any] = [: ], filePath: String, imageData: Data, boundary: String) -> Data {
        var body = Data()

        for (key, value) in parameters {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }

        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"

        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(filePath)\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageData)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")

        return body
    }
}

private extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
