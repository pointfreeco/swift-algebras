extension Semigroup where A: Numeric {
  public static var sum: Semigroup {
    return Semigroup(combine: +)
  }
  
  public static var product: Semigroup {
    return Semigroup(combine: *)
  }
}

extension Monoid where A: Numeric {
  public static var sum: Monoid {
    return Monoid(empty: 0, semigroup: .sum)
  }

  public static var product: Monoid {
    return Monoid(empty: 1, semigroup: .product)
  }
}

extension CommutativeMonoid where A: Numeric {
  public static var sum: CommutativeMonoid {
    return CommutativeMonoid(empty: 0, semigroup: .sum)
  }

  public static var product: CommutativeMonoid {
    return CommutativeMonoid(empty: 1, semigroup: .product)
  }
}

extension Semiring where A: Numeric {
  public static var numeric: Semiring {
    return Semiring(add: .sum, multiply: .product)
  }
}
