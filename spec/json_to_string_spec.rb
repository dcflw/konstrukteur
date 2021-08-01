RSpec.describe Konstrukteur::Konstrukt do
  describe "converting from JSON to String" do
    context "simple equasions" do
      it "equal" do
        k = Konstrukteur({
          "variable": "animal",
          "method": "EQ",
          "value": "dog"
        })
        expect(k.to_s).to eq("animal == 'dog'")
      end

      it "notequal" do
        k = Konstrukteur({
          "variable": "question",
          "method": "!=",
          "value": "hello?"
        })
        expect(k.to_s).to eq("question != 'hello?'")
      end

      it "greater equals" do
        k = Konstrukteur({
          "variable": "age",
          "method": ">=",
          "value": "5"
        })
        expect(k.to_s).to eq("age >= '5'")
      end

      it "lessequal" do
        k = Konstrukteur({
          "variable": "age",
          "method": "le",
          "value": "200"
        })
        expect(k.to_s).to eq("age <= '200'")
      end
    end

    context "AND operator" do
      it "combines two simple equals" do
        k = Konstrukteur({
          "operator": "AND",
          "operands": [
            {
              "variable": "age",
              "method": ">=",
              "value": "5"
            },
            {
              "variable": "age",
              "method": "<",
              "value": "100"
            }
          ]
        })
        expect(k.to_s).to eq("age >= '5' AND age < '100'")
      end

      it "combines 4 expressions" do
        k = Konstrukteur({
          "operator": "AND",
          "operands": [
            {
              "variable": "a",
              "method": "EQ",
              "value": "1"
            },
            {
              "variable": "b",
              "method": "ne",
              "value": "2"
            },
            {
              "variable": "c",
              "method": ">=",
              "value": "3"
            },
            {
              "variable": "d",
              "method": "lt",
              "value": "4"
            }
          ]
        })
        expect(k.to_s).to eq("a == '1' AND b != '2' AND c >= '3' AND d < '4'")
      end
    end

    context "OR operator" do
      it "combines two simple equasions" do
        k = Konstrukteur({
          "operator": "OR",
          "operands": [
            {
              "variable": "age",
              "method": ">",
              "value": "18"
            },
            {
              "variable": "money",
              "method": ">",
              "value": "25"
            }
          ]
        })
        expect(k.to_s).to eq("age > '18' OR money > '25'")
      end

      it "combines two sets of and constructs" do
        k = Konstrukteur({
          "operator": "OR",
          "operands": [
            {
              "operator": "AND",
              "operands": [
                {
                  "variable": "user",
                  "method": "==",
                  "value": "admin"
                },
                {
                  "variable": "password",
                  "method": "EQ",
                  "value": "test"
                }
              ]
            },
            {
              "operator": "AND",
              "operands": [
                {
                  "variable": "user",
                  "method": "==",
                  "value": "spammer"
                },
                {
                  "variable": "password",
                  "method": "EQUALS",
                  "value": "12345"
                }
              ]
            }
          ]
        })
        expect(k.to_s).to eq("(user == 'admin' AND password == 'test') OR (user == 'spammer' AND password == '12345')")
      end
    end
  end
end
