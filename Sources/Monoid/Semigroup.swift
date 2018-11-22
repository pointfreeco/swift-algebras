// TODO: should the generic be S?
public struct Semigroup<A> {
  public let combine: (A, A) -> A
  public let mcombine: (inout A, A) -> Void

  public init(combine: @escaping (A, A) -> A) {
    self.combine = combine
    self.mcombine = { accum, a in
      let result = combine(accum, a)
      accum = result
    }
  }

  public init(mcombine: @escaping (inout A, A) -> Void) {
    self.mcombine = mcombine
    self.combine = { accum, a in
      var copy = accum
      mcombine(&copy, a)
      return copy
    }
  }

  func imap<B>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> A) -> Semigroup<B> {
    return Semigroup<B>(combine: { lhs, rhs in
      f(self.combine(g(lhs), g(rhs)))
    })
  }
}

extension Semigroup {
  public var dual: Semigroup {
    return Semigroup { self.combine($1, $0) }
  }
}
