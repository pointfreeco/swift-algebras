// TODO: CommutativeSemigroup

public struct CommutativeSemigroup<A> {
  public let combine: (A, A) -> A
  public let mcombine: (inout A, A) -> Void

  public init(combine: @escaping (A, A) -> A) {
    self.combine = combine
    self.mcombine = { accum, a in
      let result = combine(accum, a)
      accum = result
    }
  }

  public init(mcombine: @escaping (inout A, A) -> Void) {
    self.mcombine = mcombine
    self.combine = { accum, a in
      var copy = accum
      mcombine(&copy, a)
      return copy
    }
  }

  func imap<B>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> A) -> CommutativeSemigroup<B> {
    return .init(combine: { lhs, rhs in
      f(self.combine(g(lhs), g(rhs)))
    })
  }

  public var dual: CommutativeSemigroup {
    return .init { self.combine($1, $0) }
  }
}

public struct IdempotentSemigroup<A> {
  public let combine: (A, A) -> A
  public let mcombine: (inout A, A) -> Void

  public init(combine: @escaping (A, A) -> A) {
    self.combine = combine
    self.mcombine = { accum, a in
      let result = combine(accum, a)
      accum = result
    }
  }

  public init(mcombine: @escaping (inout A, A) -> Void) {
    self.mcombine = mcombine
    self.combine = { accum, a in
      var copy = accum
      mcombine(&copy, a)
      return copy
    }
  }

  func imap<B>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> A) -> IdempotentSemigroup<B> {
    return .init(combine: { lhs, rhs in
      f(self.combine(g(lhs), g(rhs)))
    })
  }

  public var dual: IdempotentSemigroup {
    return .init { self.combine($1, $0) }
  }
}

public struct CommutativeMonoid<A> {
  // Law: `combine(a, b) == combine(b, a)` for all `a, b: A`.
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

  public init(monoid: Monoid<A>) {
    self.init(empty: monoid.empty, semigroup: monoid.semigroup)
  }

  public var semigroup: Semigroup<A> {
    return Semigroup(mcombine: self.mcombine)
  }

  public var monoid: Monoid<A> {
    return Monoid(empty: self.empty, semigroup: self.semigroup)
  }

  public func imap<B>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> A) -> Monoid<B> {
    return Monoid<B>(empty: f(self.empty), semigroup: self.semigroup.imap(f, g))
  }

  public var dual: CommutativeMonoid {
    return CommutativeMonoid(monoid: self.monoid.dual)
  }
}

public struct IdemptentMonoid<A> {
  // Law: `combine(a, a) == a` for all `a: A`
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

  public init(monoid: Monoid<A>) {
    self.init(empty: monoid.empty, semigroup: monoid.semigroup)
  }

  public var semigroup: Semigroup<A> {
    return Semigroup(mcombine: self.mcombine)
  }

  public var monoid: Monoid<A> {
    return Monoid(empty: self.empty, semigroup: self.semigroup)
  }

  public func imap<B>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> A) -> Monoid<B> {
    return Monoid<B>(empty: f(self.empty), semigroup: self.semigroup.imap(f, g))
  }

  public var dual: IdemptentMonoid {
    return IdemptentMonoid(monoid: self.monoid.dual)
  }
}

public struct Semiring<A> {
  public let add: CommutativeMonoid<A>
  public let multiply: Monoid<A>

  public var one: A { return self.multiply.empty }
  public var zero: A { return self.add.empty }
}
