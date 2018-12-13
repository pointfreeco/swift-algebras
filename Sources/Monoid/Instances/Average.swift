public struct Average<A: BinaryFloatingPoint>: Equatable, Hashable {
  fileprivate let count: Int
  fileprivate let sum: A

  public var average: A? {
    return self.count == 0 ? nil : .some(sum / A(count))
  }

  public init(count: Int, sum: A) {
    self.count = count
    self.sum = sum
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



