extension Semigroup {
  public func fold<S: Sequence>(_ initialValue: S.Element, _ xs: S) -> A where S.Element == A {
    return self.foldMap({ $0 })(initialValue, xs)
  }

  public func foldMap<S: Sequence>(_ f: @escaping (S.Element) -> A) -> (S.Element, S) -> A where S.Element == A {
    return { initialValue, xs in
      Monoid<S.Element>(empty: initialValue, semigroup: self).fold(xs)
    }
  }

  // todo: foldMap on Semigroup?
}

extension Monoid {
  public func fold<S: Sequence>(_ xs: S) -> A where S.Element == A {
    return self.foldMap({ $0 })(xs)
  }

  public func foldMap<S: Sequence>(_ f: @escaping (S.Element) -> A) -> (S) -> A where S.Element == A {
    return { xs in
      xs.reduce(into: self.empty) { accum, x in self.semigroup.mcombine(&accum, f(x)) }
    }
  }
}

// TODO: parallel foldMap?
