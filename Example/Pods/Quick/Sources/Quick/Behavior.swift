/**
 A `Behavior` encapsulates a set of examples that can be re-used in several locations using the `itBehavesLike` function with a context instance of the generic type.
 */

public class Behavior<Context> {

    public static var name: String { return String(describing: self) }
    /**
     override this method in your behavior to define a set of reusable examples.

     This behaves just like an example group defines using `describe` or `context`--it may contain any number of `beforeEach`
     and `afterEach` closures, as well as any number of examples (defined using `it`).

     - parameter aContext: A closure that, when evaluated, returns a `Context` instance that provide the information on the subject.
    */
    public class func spec(_ aContext: @escaping () -> Context) {}
}
