extension Semigroup where A == Bool {
  public static let any = Semigroup { $0 || $1 }
  public static let all = any.imap((!), (!))
}

extension Monoid where A == Bool {
  public static let any = Monoid(empty: false, semigroup: .any)
  public static let all = any.imap((!), (!))
}

extension CommutativeMonoid where A == Bool {
  public static let any = CommutativeMonoid(empty: false, semigroup: .any)
  public static let all = any.imap((!), (!))
}

extension IdemptentMonoid where A == Bool {
  public static let any = IdemptentMonoid(empty: false, semigroup: .any)
  public static let all = any.imap((!), (!))
}

extension Semigroup where A == Bool {
  public static let bool = Semiring(add: .any, multiply: .all)
}
