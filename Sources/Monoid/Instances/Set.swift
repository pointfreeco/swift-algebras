extension Semigroup where A: Hashable {
  public static var union: Semigroup<Set<A>> {
    return .init(mcombine: { $0.formUnion($1) })
  }

  public static var intersection: Semigroup<Set<A>> {
    return .init(mcombine: { $0.formIntersection($1) })
  }
}

extension CommutativeSemigroup where A: Hashable {
  public static var union: CommutativeSemigroup<Set<A>> {
    return .init(mcombine: { $0.formUnion($1) })
  }

  public static var intersection: CommutativeSemigroup<Set<A>> {
    return .init(mcombine: { $0.formIntersection($1) })
  }
}

extension IdempotentSemigroup where A: Hashable {
  public static var union: IdempotentSemigroup<Set<A>> {
    return .init(mcombine: { $0.formUnion($1) })
  }

  public static var intersection: IdempotentSemigroup<Set<A>> {
    return .init(mcombine: { $0.formIntersection($1) })
  }
}

extension Monoid where A: Hashable {
  public static var union: Monoid<Set<A>> {
    return .init(empty: [], mcombine: { $0.formUnion($1) })
  }
}

extension CommutativeMonoid where A: Hashable {
  public static var union: CommutativeMonoid<Set<A>> {
    return .init(empty: [], mcombine: { $0.formUnion($1) })
  }
}

extension IdemptentMonoid where A: Hashable {
  public static var union: IdemptentMonoid<Set<A>> {
    return .init(empty: [], mcombine: { $0.formUnion($1) })
  }
}
