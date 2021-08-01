require "konstrukteur/version"
require "konstrukteur/konstrukt"

module Konstrukteur
end

def Konstrukteur(data, unit: :symbol)
  Konstrukteur::Konstrukt.new(data, unit: unit)
end
