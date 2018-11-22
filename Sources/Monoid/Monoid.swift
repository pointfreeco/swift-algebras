// TODO: swift has problems when types have the same name as their package. shuold we rename the package
//       to swift-semigroup-monoid?
// TODO: should the generic be M?
public struct Monoid<A> {
  public let empty: A
  public let semigroup: Semigroup<A>

  public func imap<B>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> A) -> Monoid<B> {
    return Monoid<B>(empty: f(self.empty), semigroup: self.semigroup.imap(f, g))
  }
}

extension Monoid {
  public var dual: Monoid {
    return Monoid(empty: self.empty, semigroup: self.semigroup.dual)
  }
}
