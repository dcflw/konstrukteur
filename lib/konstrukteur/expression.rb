module Konstrukteur
  class Expression
    attr_reader :variable, :method, :value

    def initialize(args, unit: :string)
      @unit = unit
      @variable = args.fetch(:variable)
      @method = pick_method(args.fetch(:method))
      @value = args.fetch(:value)
    end

    def to_s
      "#{variable} #{method} '#{value}'"
    end

    def to_json
      {
        "variable": variable,
        "method": method.to_json,
        "value": value
      }
    end

    private

    def pick_method(method)
      case method.to_s.upcase
      when "EQ", "EQUALS", "EQUAL", "==", "==="
        Equals.new(@unit)
      when "NEQ", "NE", "NOTEQUALS", "NOTEQUAL", "!=", "!=="
        NotEquals.new(@unit)
      when "GT", "GREATER", "GREATERTHAN", ">"
        Greater.new(@unit)
      when "GE", "GREATEREQUALS", "GREATEREQUAL", ">="
        GreaterEquals.new(@unit)
      when "LS", "LESS", "LT", "LESSTHAN", "<"
        Less.new(@unit)
      when "LE", "LESSEQUALS", "LESSEQUAL", "<="
        LessEquals.new(@unit)
      else
        raise "Unknown Operator"
      end
    end
  end
end
