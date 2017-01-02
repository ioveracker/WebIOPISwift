import Foundation

/// A class that represents the GPIO header on a Raspberry Pi. Provides access to the WebIOPi API.
public class GPIOType {

    public var pi: WebIOPi!

    fileprivate let session = URLSession(configuration: URLSessionConfiguration.default)

    /// Fetches the GPIO configuration from the configured host.
    ///
    /// - parameter completion: A closure to be executed upon completion of the network request.
    public func getConfiguration(completion: @escaping ((Status, GPIOConfiguration?) -> Void)) {
        let url = pi.url.appendingPathComponent("/*")
        session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                // TODO: Check error status code.
                completion(.notFound, nil)
                return
            }

            var json: [String: Any]
            do {
                json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            } catch let error as NSError {
                print(error)
                completion(.parseError, nil)
                return
            }

            let config = GPIOConfiguration(pi: self.pi, json: json)
            completion(.ok, config)
        }.resume()
    }

    public func set(pin: Int, function: Function, completion: @escaping ((Status) -> Void)) {
        let url = pi.url.appendingPathComponent("/GPIO/\(pin)/function/\(function)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.notFound)
                return
            }

            completion(Status.makeFromHTTPStatusCode(code: httpResponse.statusCode) ?? .notFound)
        }.resume()
    }

    public func set(pin: Int, value: Value, completion: @escaping ((Status) -> Void)) {
        let url = pi.url.appendingPathComponent("/GPIO/\(pin)/value/\(value.intValue)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.notFound)
                return
            }

            completion(Status.makeFromHTTPStatusCode(code: httpResponse.statusCode) ?? .notFound)

        }.resume()
    }
    
}
