require "konstrukteur/operators"
require "konstrukteur/expression"

module Konstrukteur
  class Konstrukt
    attr_reader :children

    def initialize(obj, unit: :symbol, root: true)
      @root = root
      @unit = unit
      @children = if obj.is_a?(Hash)
        parse_hash(obj)
      elsif obj.is_a?(Array)
        parse_array(obj)
      else
        raise "Konstruktionsfehler. Don't know what to build."
      end
    end

    def to_s
      if @root
        children.to_s.delete_prefix("(").delete_suffix(")")
      else
        children.to_s
      end
    end

    def to_json
      children.to_json
    end

    private

    def parse_array(obj)
      obj.collect { |x| Konstrukteur::Konstrukt.new(x, unit: @unit, root: false) }
    end

    def parse_hash(obj)
      if obj[:operands] && obj[:operator]
        clazz = "Konstrukteur::#{obj[:operator].capitalize.upcase}"
        Object.const_get(clazz).new(obj[:operands], unit: @unit, root: false)
      elsif obj[:variable] && obj[:method] && obj[:value]
        Konstrukteur::Expression.new(obj, unit: @unit)
      else
        "don't know what to do"
      end
    end
  end

  class Joins < Konstrukt
    def to_s
      "(#{children.join(" #{self.class::FORMAT[:string]} ")})"
    end

    def to_json
      {
        "operator": self.class::FORMAT[:string],
        "operands": children.collect(&:to_json)
      }
    end
  end

  class AND < Joins
    FORMAT = {string: "AND", symbol: "&&"}
  end

  class OR < Joins
    FORMAT = {string: "OR", symbol: "||"}
  end
end
