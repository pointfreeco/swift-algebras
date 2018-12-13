extension Semigroup where A == () {
  public static let void = Semigroup(mcombine: { _, _ in })
}

extension CommutativeSemigroup where A == () {
  public static let void = CommutativeSemigroup(mcombine: { _, _ in })
}

extension IdempotentSemigroup where A == () {
  public static let void = IdempotentSemigroup(mcombine: { _, _ in })
}

extension Monoid where A == () {
  public static let void = Monoid(empty: (), mcombine: { _, _ in })
}

extension CommutativeMonoid where A == () {
  public static let void = CommutativeMonoid(empty: (), mcombine: { _, _ in })
}

extension IdemptentMonoid where A == () {
  public static let void = IdemptentMonoid(empty: (), mcombine: { _, _ in })
}

extension Semiring where A == () {
  public static let void = Semiring(add: .void, multiply: .void)
}
