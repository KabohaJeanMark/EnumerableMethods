# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    until i == size
      yield to_a[i]
      i += 1
    end

    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    my_each do |element|
      yield(element, i)
      i += 1
    end

    self
  end

  def my_select
    selected_arr = []
    to_a.my_each { |item| selected_arr.push(item) if yield item }
    selected_arr
  end

  def my_all?(argm = nil)
    if block_given?
      to_a.my_each { |item| return false if yield(item) == false }
      return true
    elsif argm.nil?
      to_a.my_each { |i| return false if i.nil? || i == false }
    elsif !argm.nil? && (argm.is_a? Class)
      to_a.my_each { |i| return false if i.class != argm }
    elsif !argm.nil? && argm.instance_of?(Regexp)
      to_a.my_each { |i| return false unless argm.match(i) }
    else
      to_a.my_each { |i| return false if i != argm }
    end
    true
  end

  def my_any?(argm = nil)
    if block_given?
      to_a.my_each { |item| return true if yield(item) }
      return false
    elsif argm.nil?
      to_a.my_each { |i| return true if i.nil? || i == true }
    elsif !argm.nil? && (argm.is_a? Class)
      to_a.my_each { |i| return true if i.instance_of?(argm) }
    elsif !argm.nil? && argm.instance_of?(Regexp)
      to_a.my_each { |i| return true if argm.match(i) }
    else
      to_a.my_each { |i| return true if i == argm }
    end
    false
  end

  def my_none?(argm = nil, &block)
    !my_any?(argm, &block)
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

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity