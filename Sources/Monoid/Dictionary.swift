extension Semigroup {
  // TODO: rename arg to something like `uniquingKeysWith`?
  public static func merge<K, V>(with witness: Semigroup<V>) -> Semigroup<[K: V]> {
    return Semigroup<[K: V]> { lhs, rhs in
      lhs.merge(rhs, uniquingKeysWith: witness.combine)
    }
  }
}

extension Monoid {
  // TODO: rename arg to something like `uniquingKeysWith`?
  public static func merge<K, V>(with witness: Monoid<V>) -> Monoid<[K: V]> {
    return Monoid<[K: V]>(
      empty: [:],
      semigroup: .merge(with: witness.semigroup)
    )
  }
}
