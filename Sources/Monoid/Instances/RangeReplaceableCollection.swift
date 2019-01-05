extension Semigroup where A: RangeReplaceableCollection {
  public static var joined: Semigroup<A> {
    return Semigroup<A>(mcombine: { $0.append(contentsOf: $1) })
  }

  public static func joined(separator: A.Element) -> Semigroup<A> {
    return Semigroup<A>(mcombine: {
      if !$0.isEmpty { $0.append(separator) }
      $0.append(contentsOf: $1)
    })
  }
}

extension Monoid where A: RangeReplaceableCollection {
  public static var joined: Monoid<A> {
    return Monoid<A>(empty: .init(), semigroup: .joined)
  }

  public static func joined(separator: A.Element) -> Monoid<A> {
    return Monoid<A>(empty: .init(), semigroup: .joined(separator: separator))
  }
}
