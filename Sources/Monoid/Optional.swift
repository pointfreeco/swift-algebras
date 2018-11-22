extension Semigroup {
  public static var last: Semigroup<A?> {
    return .init { $1 ?? $0 }
  }
  public static var first: Semigroup<A?> {
    return .init { $0 ?? $1 }
  }
}

extension Semigroup {
  public static func optional(_ witness: Semigroup<A>) -> Monoid<A?> {
    return Monoid<A?>(empty: nil, semigroup: Semigroup<A?>.init { lhs, rhs -> Void in
      // TODO: better way?
      guard lhs != nil, let rhs1 = rhs else { lhs = lhs ?? rhs; return }
      witness.mcombine(&lhs!, rhs1)
    })
  }
}

extension Monoid {
  public static var last: Monoid<A?> {
    return .init(empty: nil, semigroup: Semigroup.last)
  }
  public static var first: Monoid<A?> {
    return self.last.dual
  }
}
