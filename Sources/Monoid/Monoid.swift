// TODO: should the generic be M?
public struct Monoid<A> {
  public let empty: A
  public let semigroup: Semigroup<A>
  public func concat<S: Sequence>(_ xs: S) -> A where S.Element == A {
    return self.foldMap({ $0 })(xs)
  }

  // todo: move to file
  public func foldMap<S: Sequence>(_ f: @escaping (S.Element) -> A) -> (S) -> A where S.Element == A {
    return { xs in
      xs.reduce(into: self.empty) { accum, x in self.semigroup.mcombine(&accum, f(x)) }
    }
  }
}

extension Monoid {
  public var dual: Monoid {
    return Monoid(empty: self.empty, semigroup: self.semigroup.dual)
  }
}
