// TODO: should the generic be S?
public struct Semigroup<A> {
  // Law: `combine(combine(a, b), c) == combine(a, combine(b, c))` for all a, b, c: A.
  public let mcombine: (inout A, A) -> Void

  public var combine: (A, A) -> A {
    return { lhs, rhs in
      var result = lhs
      self.mcombine(&result, rhs)
      return result
    }
  }

  public init(combine: @escaping (A, A) -> A) {
    self.mcombine = { accum, a in
      let result = combine(accum, a)
      accum = result
    }
  }

  public init(mcombine: @escaping (inout A, A) -> Void) {
    self.mcombine = mcombine
  }

  func imap<B>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> A) -> Semigroup<B> {
    return Semigroup<B>(combine: { lhs, rhs in
      f(self.combine(g(lhs), g(rhs)))
    })
  }
  
  public var dual: Semigroup {
    return Semigroup { self.combine($1, $0) }
  }
}
