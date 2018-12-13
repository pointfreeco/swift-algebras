public func tuple2<A, B>(_ a: Semigroup<A>, _ b: Semigroup<B>) -> Semigroup<(A, B)> {
  return Semigroup(mcombine: { lhs, rhs in
    a.mcombine(&lhs.0, rhs.0)
    b.mcombine(&lhs.1, rhs.1)
  })
}

public func tuple2<A, B>(_ a: Monoid<A>, _ b: Monoid<B>) -> Monoid<(A, B)> {
  return Monoid(empty: (a.empty, b.empty), semigroup: tuple2(a.semigroup, b.semigroup))
}

public func tuple3<A, B, C>(_ a: Semigroup<A>, _ b: Semigroup<B>, _ c: Semigroup<C>) -> Semigroup<(A, B, C)> {
  return Semigroup(mcombine: { lhs, rhs in
    a.mcombine(&lhs.0, rhs.0)
    b.mcombine(&lhs.1, rhs.1)
    c.mcombine(&lhs.2, rhs.2)
  })
}

public func tuple3<A, B, C>(_ a: Monoid<A>, _ b: Monoid<B>, _ c: Monoid<C>) -> Monoid<(A, B, C)> {
  return Monoid(empty: (a.empty, b.empty, c.empty), semigroup: tuple3(a.semigroup, b.semigroup, c.semigroup))
}
