module Enumerable
  def my_each
    i = 0
    until i == size
      yield(self[i])
      i += 1
    end
  end
end

# example to show my_each is working
[1, 2, 3].my_each { |num| puts num * 2 }
