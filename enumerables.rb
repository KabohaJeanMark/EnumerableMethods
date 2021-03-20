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
    return to_enum(:my_select) unless block_given?

    selected_arr = []
    to_a.my_each { |item| selected_arr.push(item) if yield item }
    selected_arr
  end

  def my_all?(argm = nil)
    if block_given? && !argm
      to_a.my_each { |item| return false if yield(item) == false }
      return true
    elsif argm.nil?
      to_a.my_each { |i| return false if i.nil? || i == false }
    elsif argm.is_a? Class
      to_a.my_each { |i| return false unless i.is_a?(argm) }
      return true
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
      to_a.my_each { |i| return true if i }
    elsif !argm.nil? && (argm.is_a? Class)
      to_a.my_each { |i| return true if i.is_a?(argm) }
    elsif !argm.nil? && argm.instance_of?(Regexp)
      to_a.my_each { |i| return true if argm.match(i) }
    else
      to_a.my_each { |i| return true if i == argm }
    end
    false
  end

  def my_none?(argm = nil, &block)
    item = false

    selcted_arr = if !argm

                    block_given? ? select(&block) : select { |i| i }
                  elsif argm.is_a?(Regexp)
                    select { |i| argm.match(i) }
                  elsif argm.is_a?(Class)
                    select { |i| i.class <= argm }
                  else
                    select { |i| i == argm }
                  end
    item = true if selcted_arr.to_a.empty?
    item
  end

  def my_count(argm = nil)
    if argm
      selected = my_select { |element| element == argm }
      selected.size
    else
      return to_a.size unless block_given?

      i = 0

      my_each do |_element|
        yield(el) && i += 1
      end
      i
    end
  end

  def my_map(argm = nil)
    return to_enum if !block_given? && !argm

    items = clone.to_a
    items.my_each_with_index do |item, i|
      items[i] = if argm
                   argm.call(item)
                 else
                   yield item
                 end
    end
    items
  end

  def my_inject(argm = nil, symbl = nil)
    selcted = ''
    if argm.class <= Symbol || (symbl.class <= Symbol and argm)
      if symbl.nil?
        i = 1
        selcted = to_a[0]
        while i < to_a.size
          selcted = selcted.send(argm, to_a[i])
          i += 1
        end
      else
        selcted = argm
        my_each { |element| selcted = selcted.send(symbl, element) }
      end
    elsif block_given?
      if argm
        selcted = argm
        to_a.my_each { |element| selcted = yield(selcted, element) }
      else
        i = 1
        selcted = to_a[0]
        while i < to_a.size
          selcted = yield(selcted, to_a[i])
          i += 1
        end
      end
    else
      raise LocalJumpError, 'no block given'
    end
    selcted
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |p, i| p * i }
end

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
