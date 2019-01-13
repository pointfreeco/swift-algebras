import Dispatch

extension Semigroup {
  public func fold<S: Sequence>(_ initialValue: S.Element, _ xs: S) -> S.Element where S.Element == A {
    return self.foldMap({ $0 })(initialValue, xs)
  }

  public func parallelFold<S: Sequence>(_ initialValue: S.Element, _ xs: S) -> A where S.Element == A {

    let coreCount = sysconf(CInt(_SC_NPROCESSORS_ONLN))
    let chunkSize = xs.underestimatedCount / coreCount

    var result = initialValue
    var results: [A?] = [A?](repeating: nil, count: coreCount)

    DispatchQueue.concurrentPerform(iterations: coreCount) { idx in
      xs.suffix(idx * coreCount).prefix(chunkSize)
    }

    (1...1_000_000_000).underestimatedCount

    for intermediateResult in results {
      self.mcombine(&result, intermediateResult!)
    }

    return result
//    return self.foldMap({ $0 })(initialValue, xs)
  }

  // todo: make an inout

  // TODO: it should be possible to get rid of `where S.Element == A`
  public func foldMap<S: Sequence>(_ f: @escaping (S.Element) -> A) -> (S.Element, S) -> A where S.Element == A {
    return { initialValue, xs in
      Monoid<S.Element>(empty: initialValue, semigroup: self).fold(xs)
    }
  }

  // todo: foldMap on Semigroup?
}

extension Monoid {
  // todo: make inout
  public func fold<S: Sequence>(_ xs: S) -> A where S.Element == A {
    return self.foldMap({ $0 })(xs)
  }

  public func parallelFold<S: RandomAccessCollection>(_ xs: S) -> S.Element where S.Element == A {
    let coreCount = sysconf(CInt(_SC_NPROCESSORS_ONLN))
    let chunkSize = xs.underestimatedCount / coreCount

    var result = self.empty
    var results: [A?] = [A?](repeating: nil, count: coreCount)

    DispatchQueue.concurrentPerform(iterations: coreCount) { idx in
      results[idx] = xs
        .suffix(from: xs.index(xs.startIndex, offsetBy: idx * chunkSize))
        .prefix(chunkSize)
        .reduce(into: self.empty, self.mcombine)
//        .fold(self)
    }

    for intermediateResult in results {
      self.mcombine(&result, intermediateResult!)
    }

    return result
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
