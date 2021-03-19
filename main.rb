module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    until i == size
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

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

  def my_map(&_my_proc)
    arr = []
    return self unless block_given?

    my_each { |item| arr.push yield(item) }
    arr
  end

  def my_inject(acc)
    to_a.my_each do |x|
      acc = yield(acc, x)
    end
    acc
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |p, i| p * i }
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

puts '------ my_map method example---------'
example_count = [2, 4, 5, 1, 7, 6, 8].my_map { |n| n + 10 }
p example_count

puts '------ my_inject method example---------'
injected_example = (5..10).my_inject(0) { |sum, n| sum + n }
p injected_example

puts '------ multiply_els method example---------'
p multiply_els([2, 3, 2])
