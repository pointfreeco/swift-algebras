extension Semigroup {
  public static var endo: Semigroup<(A) -> A> {
    return .init { lhs, rhs in
      return { a in rhs(lhs(a)) }
    }
  }

  // TODO: `mendo`, or `inoutEndo`, or...?
  public static var inoutEndo: Semigroup<(inout A) -> Void> {
    return .init { lhs, rhs in
      return { a in
        lhs(&a)
        rhs(&a)
      }
    }
  }
}

extension Monoid {
  public static var endo: Monoid<(A) -> A> {
    return .init(empty: { $0 }, semigroup: Semigroup.endo)
  }

  public static var inoutEndo: Monoid<(inout A) -> Void> {
    return .init(empty: { _ in }, semigroup: Semigroup.inoutEndo)
  }
}
