module Enumerable
  def my_each
    i = 0
    until i == size
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    until i == size
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    selected_arr = []
    to_a.my_each { |item| selected_arr.push(item) if yield item }
    selected_arr
  end
end

# example to show my_each is working
[1, 2, 3].my_each { |num| puts num * 2 }

# example to show my_each_with_index is working
[1, 2, 3].my_each_with_index { |n, i| puts "the item is #{n} and the index is #{i}" }

example_select = %w[Shaher jean mark Jordy Stranger].my_select { |name| name != 'Stranger' }
puts example_select
