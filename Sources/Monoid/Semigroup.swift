// TODO: should the generic be S?
public struct Semigroup<A> {
  public let combine: (A, A) -> A
  public let mcombine: (inout A, A) -> Void

  // TODO: should we make this a named param for when we don't want to use trailng syntax and be super clear?
  public init(_ combine: @escaping (A, A) -> A) {
    self.combine = combine
    self.mcombine = { accum, a in
      let result = combine(accum, a)
      accum = result
    }
  }

  public init(_ mcombine: @escaping (inout A, A) -> Void) {
    self.mcombine = mcombine
    self.combine = { accum, a in
      var copy = accum
      mcombine(&copy, a)
      return copy
    }
  }

  // todo: move this somewhere else and maybe rename
  public func concat<S: Sequence>(_ initialValue: S.Element, _ xs: S) -> A where S.Element == A {
    return xs.reduce(into: initialValue, self.mcombine)
  }
}

extension Semigroup {
  public var dual: Semigroup {
    return Semigroup { self.combine($1, $0) }
  }
}
