extension Semigroup {
  public static func pointwise<A0>(into witness: Semigroup<A>) -> Semigroup<(A0) -> A> {
    return Semigroup<(A0) -> A> { lhs, rhs in
      return { a0 in
        witness.combine(lhs(a0), rhs(a0))
      }
    }
  }
}

extension Monoid {
  public static func pointwise<A0>(into witness: Monoid<A>) -> Monoid<(A0) -> A> {
    return Monoid<(A0) -> A>(
      empty: { (a0: A0) in witness.empty },
      semigroup: Semigroup<A>.pointwise(into: witness.semigroup)
    )
  }
}
