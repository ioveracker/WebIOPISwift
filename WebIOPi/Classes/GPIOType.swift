import Foundation

/// A class that represents the GPIO header on a Raspberry Pi. Provides access to the WebIOPi API.
public class GPIOType {

    fileprivate let session = URLSession(configuration: URLSessionConfiguration.default)
    fileprivate let baseURL: URL

    /// Creates a new `GPIOType` instance configured to communicate with the given host.
    ///
    /// - parameter host: The Raspberry Pi URL.
    init(host: String) {
        baseURL = URL(string: "\(host)")!
    }

    /// Fetches the GPIO configuration from the configured host.
    ///
    /// - parameter completion: A closure to be executed upon completion of the network request.
    public func getConfiguration(completion: @escaping ((Status, GPIOConfiguration?) -> Void)) {
        let url = baseURL.appendingPathComponent("/*")
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

            let config = GPIOConfiguration(json: json)
            completion(.ok, config)
        }.resume()
    }

}
