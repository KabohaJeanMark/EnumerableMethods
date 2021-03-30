require_relative '../enumerables'
describe Enumerable do
    describe "#my_each" do
      
      it "prints the elemsnt in the given range" do
        expect { (1..5).my_each { |el| p el} }.to output("1\n2\n3\n4\n5\n").to_stdout
      end
    end
end