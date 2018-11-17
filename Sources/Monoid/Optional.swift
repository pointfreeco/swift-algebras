
extension Semigroup {
  public static func last<B>() -> Semigroup<B?> {
    return Semigroup<B?> { $1 ?? $0 }
  }
  public static func first<B>() -> Semigroup<B?> {
    return Semigroup<B?> { $0 ?? $1 }
  }
}

extension Monoid {
  public static func optional(_ witness: Semigroup<A>) -> Monoid<A?> {
    return Monoid<A?>(empty: nil, semigroup: Semigroup<A?>.init { lhs, rhs -> Void in
      // TODO: better way?
      guard lhs != nil, let rhs1 = rhs else { lhs = lhs ?? rhs; return }
      witness.mcombine(&lhs!, rhs1)
    })
  }
}

extension Monoid {
  public static func last<B>() -> Monoid<B?> {
    return Monoid<B?>(empty: nil, semigroup: .last())
  }
  public static func first<B>() -> Monoid<B?> {
    return self.last().dual
  }
}
