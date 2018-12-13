extension Semigroup {
  public func fold<S: Sequence>(_ initialValue: S.Element, _ xs: S) -> A where S.Element == A {
    return self.foldMap({ $0 })(initialValue, xs)
  }

  // TODO: it should be possible to get rid of `where S.Element == A`
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

  public func foldMap<S: Sequence>(_ f: @escaping (S.Element) -> A) -> (S) -> A {
    return { xs in
      xs.reduce(into: self.empty) { accum, x in self.semigroup.mcombine(&accum, f(x)) }
    }
  }
}

// TODO: parallel foldMap?

extension Sequence {
  public func fold(_ semigroup: Semigroup<Element>, _ initialValue: Element) -> Element {
    return semigroup.fold(initialValue, self)
  }

  public func fold( _ monoid: Monoid<Element>) -> Element {
    return monoid.fold(self)
  }

  public func foldMap<A>(_ monoid: Monoid<A>, _ f: @escaping (Element) -> A) -> (Self) -> A {
    return { xs in
      xs.reduce(into: monoid.empty) { accum, x in monoid.mcombine(&accum, f(x)) }
    }
  }
}
