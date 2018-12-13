// TODO: should the generic be M?
public struct Monoid<A> {
  public let empty: A
  public let combine: (A, A) -> A
  public let mcombine: (inout A, A) -> Void

  public init(empty: A, combine: @escaping (A, A) -> A) {
    self.empty = empty
    self.combine = combine
    self.mcombine = { lhs, rhs in lhs = combine(lhs, rhs) }
  }

  public init(empty: A, mcombine: @escaping (inout A, A) -> Void) {
    self.empty = empty
    self.mcombine = mcombine
    self.combine = { lhs, rhs in var lhs = lhs; mcombine(&lhs, rhs); return lhs }
  }

  public init(empty: A, semigroup: Semigroup<A>) {
    self.empty = empty
    self.combine = semigroup.combine
    self.mcombine = semigroup.mcombine
  }

  public var semigroup: Semigroup<A> {
    return Semigroup(mcombine: self.mcombine)
  }

  public func imap<B>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> A) -> Monoid<B> {
    return Monoid<B>(empty: f(self.empty), semigroup: self.semigroup.imap(f, g))
  }

  public var dual: Monoid {
    return Monoid(empty: self.empty, semigroup: self.semigroup.dual)
  }
}
