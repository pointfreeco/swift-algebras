extension Semigroup {
  public static var endo: Semigroup<(A) -> A> {
    return .init { lhs, rhs in
      return { a in rhs(lhs(a)) }
    }
  }
}

extension Monoid {
  public static var endo: Monoid<(A) -> A> {
    return .init(empty: { $0 }, semigroup: Semigroup.endo)
  }
}
