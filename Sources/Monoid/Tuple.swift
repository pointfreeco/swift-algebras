extension Semigroup {
  public static func tuple2<B, C>(_ b: Semigroup<B>, _ c: Semigroup<C>) -> Semigroup<(B, C)> {
    return Semigroup<(B, C)> { lhs, rhs in
      (b.combine(lhs.0, rhs.0), c.combine(lhs.1, rhs.1))
    }
  }
}

extension Monoid {
  public static func tuple2<B, C>(_ b: Monoid<B>, _ c: Monoid<C>) -> Monoid<(B, C)> {
    return Monoid<(B, C)>(empty: (b.empty, c.empty), semigroup: .tuple2(b.semigroup, c.semigroup))
  }
}
