# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

# Adding my_methods to Enumerable module
module Enumerable
  def my_each
    return to_enum unless block_given?

    size.times { |n| yield self[n] }
  end

  def my_each_with_index
    return to_enum unless block_given?

    size.times { |n| yield self[n], n }
  end

  def my_select
    return to_enum unless block_given?

    array = []
    my_each { |n| array.push(n) if yield(n) }
    array
  end

  def my_all?(arg = nil)
    if arg.is_a?(Regexp)
      my_each { |n| return false unless arg.match(n) }
    elsif arg.is_a?(Integer) || arg.is_a?(String)
      my_each { |n| return false unless n == arg }
    elsif block_given?
      my_each { |n| return false unless yield(n) }
    elsif arg.nil?
      my_each { |n| return false unless n }
    else
      my_each { |n| return false unless n.is_a?(arg) }
    end
    true
  end

  def my_any?(arg = nil)
    if arg.is_a?(Regexp)
      my_each { |n| return true if arg.match(n) }
    elsif arg.is_a?(Integer) || arg.is_a?(String)
      my_each { |n| return true if n == arg }
    elsif block_given?
      my_each { |n| return true if yield(n) }
    elsif arg.nil?
      my_each { |n| return true if n }
    else
      my_each { |n| return true if n.is_a?(arg) }
    end
    false
  end

  def my_none?(arg = nil)
    if arg.is_a?(Regexp)
      my_each { |n| return false if arg.match(n) }
    elsif arg.is_a?(Integer) || arg.is_a?(String)
      my_each { |n| return false if n == arg }
    elsif block_given?
      my_each { |n| return false if yield(n) }
    elsif arg.nil?
      my_each { |n| return false if n }
    else
      my_each { |n| return false if n.is_a?(arg) }
    end
    true
  end

  def my_count(arg = nil)
    count = 0
    if block_given? && arg.nil?
      my_each { |n| count += 1 if yield(n) }
    elsif arg.nil?
      my_each { |n| count += 1 if n }
    elsif arg.is_a?(Integer) || arg.is_a?(String)
      my_each { |n| count += 1 if n == arg }
    else
      my_each { |n| count += 1 if n.is_a?(arg) }
    end
    count
  end

  def my_map(proc = nil, &block)
    return to_enum unless proc || block

    proc = block if block
    obj = to_a
    obj.size.times { |n| obj[n] = proc.call(obj[n]) }
    obj
  end

  def my_inject(initial = 0, arg = nil)
    obj = to_a
    memo = obj[0]

    if initial.is_a?(Symbol)
      arg = initial
      initial = 0
      initial, memo = 1 if arg == :/ || arg == :* && initial.zero?
    end

    memo = (my_inject { |oper, n| oper.public_send(arg, n) }).public_send(arg, initial) unless arg.nil?

    if block_given?
      if initial.zero?
        (obj.size - 1).times { |n| memo = yield(memo, obj[n + 1]) }
      else
        obj.size.times { |n| initial = yield(initial, obj[n]) }
        memo = initial
      end
    end
    memo
  end

  def multiply_els(array)
    array.my_inject(:*)
  end
end

# rubocop:enable all
