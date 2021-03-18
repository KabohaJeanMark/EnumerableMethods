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

  def my_all?
    selected_arr = []
    to_a.my_each { |item| selected_arr.push(item) if yield item }
    selected_arr.size == size
  end

  def my_any?
    selected_arr = []
    to_a.my_each { |item| selected_arr.push(item) if yield item }
    selected_arr.size.positive?
  end

  def my_none?
    selected_arr = []
    to_a.my_each { |item| selected_arr.push(item) if yield item }
    selected_arr.size != size
  end

  def my_count(num = nil)
    if num.nil?
      size
    else
      selected_arr = []
      to_a.my_each { |item| selected_arr.push(item) if item == num }
      selected_arr.size
    end
  end
end

puts '------ my_each method example---------'
[1, 2, 3].my_each { |num| puts num * 2 }
puts

puts '------ my_each_with_index method example---------'
[1, 2, 3].my_each_with_index { |n, i| puts "the item is #{n} and the index is #{i}" }
puts

puts '------ my_select method example---------'
example_select = %w[Shaher jean mark Jordy Stranger].my_select { |name| name != 'Stranger' }
puts example_select

puts '------ my_all? method example---------'
example_all = %w[cat bat bird wings].my_all? { |name| name.size >= 3 }
puts example_all

puts '------ my_any? method example---------'
example_any = [11, 15, 17, 21].my_any?(&:even?)
puts example_any

puts '------ my_none? method example---------'
example_none = [6, 8, 4, 2].my_none?(&:odd?)
puts example_none

puts '------ my_count? method example---------'
example_count = [2, 8, 3, 2, 6, 8].my_count(2)
puts example_count

puts '------ my_count? method example no args passed---------'
example_count = [2, 8, 3, 2, 6, 8].my_count
puts example_count
