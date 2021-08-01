module Konstrukteur
  class Formatter
    def initialize(unit = :symbol)
      @unit = unit.to_sym
    end

    def to_s
      self.class::FORMAT[@unit]
    end

    def to_json
      to_s
    end
  end

  class Equals < Formatter
    FORMAT = {symbol: "==", string: "EQ"}
  end

  class NotEquals < Formatter
    FORMAT = {symbol: "!=", string: "NE"}
  end

  class Greater < Formatter
    FORMAT = {symbol: ">", string: "GT"}
  end

  class GreaterEquals < Formatter
    FORMAT = {symbol: ">=", string: "GE"}
  end

  class Less < Formatter
    FORMAT = {symbol: "<", string: "LT"}
  end

  class LessEquals < Formatter
    FORMAT = {symbol: "<=", string: "LE"}
  end
end
