// todo: should we have swift-comparator so that we can do a `.max(with: \String.count)` etc?

extension Semigroup where A: Comparable {
  public static var max: Semigroup<A> {
    return Semigroup<A>(combine: Swift.max)
  }
}

extension Semigroup where A: Comparable {
  public static var min: Semigroup<A> {
    return Semigroup<A>(combine: Swift.min)
  }
}

extension Monoid where A: Comparable & FixedWidthInteger {
  public static var max: Monoid<A> {
    return Monoid<A>(empty: .min, semigroup: .max)
  }
}

extension Monoid where A: Comparable & FloatingPoint {
  public static var max: Monoid<A> {
    return Monoid<A>(empty: -.greatestFiniteMagnitude, semigroup: .max)
  }
}

extension Monoid where A: Comparable & FixedWidthInteger {
  public static var min: Monoid<A> {
    return Monoid<A>(empty: .max, semigroup: .min)
  }
}

extension Monoid where A: Comparable & FloatingPoint {
  public static var min: Monoid<A> {
    return Monoid<A>(empty: .greatestFiniteMagnitude, semigroup: .min)
  }
}
