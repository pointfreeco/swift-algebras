extension Semigroup where A == Bool {
  public static let any = Semigroup { $0 || $1 }

  public static let all = any.imap((!), (!))
}

extension Monoid where A == Bool {
  public static let any = Monoid(empty: false, semigroup: .any)
  
  public static let all = any.imap((!), (!))
}
