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
            let status = Status.makeFromURLResponse(response)
            if status != .ok {
                completion(status, nil)
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
            completion(status, config)
        }.resume()
    }

    public func setFunction(_ function: Function, pin: Int, completion: @escaping ((Status) -> Void)) {
        post(url: pi.url.appendingPathComponent("/GPIO/\(pin)/function/\(function)"),
             completion: completion)
    }

    public func getFunction(pin: Int, completion: @escaping ((Status, Function?) -> Void)) {
        let url = pi.url.appendingPathComponent("/GPIO/\(pin)/function")
        session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.notFound, nil)
                return
            }

            guard let string = String(data: data, encoding: .utf8) else {
                completion(.notFound, nil)
                return
            }
            
            completion(Status.makeFromURLResponse(response),
                       Function.makeFromString(string: string))
        }.resume()
    }

    public func setValue(_ value: Value, pin: Int, completion: @escaping ((Status) -> Void)) {
        post(url: pi.url.appendingPathComponent("/GPIO/\(pin)/value/\(value.intValue)"),
             completion: completion)
    }

    public func pulse(pin: Int, completion: @escaping ((Status) -> Void)) {
        post(url: pi.url.appendingPathComponent("/GPIO/\(pin)/pulse/"),
             completion: completion)
    }

    public func runSequence(_ sequence: [Value],
                            delay: Int,
                            pin: Int,
                            completion: @escaping ((Status) -> Void)) {
        let sequenceString = sequence.reduce("") { "\($0)\($1.intValue)" }
        post(url: pi.url.appendingPathComponent("/GPIO/\(pin)/sequence/\(delay),\(sequenceString)"),
             completion: completion)
    }
    
}

private extension GPIOType {

    func post(url: URL, completion: @escaping ((Status) -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        session.dataTask(with: request) { data, response, error in
            completion(Status.makeFromURLResponse(response))
        }.resume()
    }

}
