import Foundation

// todo: finish

public struct Variance<A: BinaryFloatingPoint>: Equatable, Hashable {
  fileprivate var count: Int
  fileprivate var sum: A
  fileprivate var sumOfSquares: A

  public var variance: A {
    fatalError()
  }

  public init(count: Int, sum: A, sumOfSquares: A) {
    self.count = count
    self.sum = sum
    self.sumOfSquares = sumOfSquares
  }

  public init(value: A ) {
    self.count = 1
    self.sum = value
    self.sumOfSquares = value
  }
}

extension Semigroup where A: BinaryFloatingPoint {
  public static var variance: Semigroup<Variance<A>> {
    return Semigroup<Variance<A>>(mcombine: { lhs, rhs in
      let n = { $0 * $0 }(lhs.sum * A(rhs.count) - A(lhs.count) * rhs.sum)
      let d = A((lhs.count + rhs.count) * lhs.count * rhs.count)

      lhs.count += rhs.count
      lhs.sum += rhs.sum
      lhs.sumOfSquares = lhs.count == 0 ? rhs.sumOfSquares
        : rhs.count == 0 ? lhs.sumOfSquares
        : lhs.sumOfSquares + rhs.sumOfSquares + n / d
    })
  }
}
