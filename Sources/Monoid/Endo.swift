extension Semigroup {
  public static func endo<B>() -> Semigroup<(B) -> B> {
    return Semigroup<(B) -> B> { lhs, rhs in
      return { a in rhs(lhs(a)) }
    }
  }
}

extension Monoid {
  public static var endo: Monoid<(A) -> A> {
    return Monoid<(A) -> A>(
      empty: { $0 },
      semigroup: .endo()
    )
  }
}
