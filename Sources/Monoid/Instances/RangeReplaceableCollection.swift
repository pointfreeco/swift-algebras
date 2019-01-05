extension Semigroup where A: RangeReplaceableCollection {
  // TODO: what to name this? `concat`? `append`?
  public static var concat: Semigroup<A> {
    return Semigroup<A>(mcombine: { $0.append(contentsOf: $1) })
  }
}

extension Monoid where A: RangeReplaceableCollection {
  public static var concat: Monoid<A> {
    return Monoid<A>(empty: .init(), semigroup: .concat)
  }
}
