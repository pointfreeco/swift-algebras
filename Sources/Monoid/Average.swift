public struct Average<A: BinaryFloatingPoint>: Equatable, Hashable {
  fileprivate let count: Int
  fileprivate let sum: A

  public static func == (lhs: Average, rhs: Average) -> Bool {
    return lhs.sum * A(rhs.count) == A(lhs.count) * rhs.sum
  }

  public var average: A? {
    return self.count == 0 ? nil : .some(sum / A(count))
  }
}

extension Average {
  public init(value: A) {
    self.count = 1
    self.sum = value
  }
}

extension Semigroup where A: BinaryFloatingPoint {
  public static var average: Semigroup<Average<A>> {
    return tuple2(.sum, .sum).imap(Average.init, { ($0.count, $0.sum )})
  }
}
