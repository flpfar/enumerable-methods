# frozen_string_literal: true

# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/AbcSize

# Adding methods to Enumerable module
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
    if block_given? && arg.nil?
      my_each { |n| return false unless yield(n) }
    elsif arg.nil?
      my_each { |n| return false unless n }
    elsif arg.is_a?(Regexp)
      my_each { |n| return false unless arg.match(n) }
    elsif arg.is_a?(Integer) || arg.is_a?(String)
      my_each { |n| return false unless n == arg }
    else
      my_each { |n| return false unless n.is_a?(arg) }
    end
    true
  end

  def my_any?(arg = nil)
    if block_given? && arg.nil?
      my_each { |n| return true if yield(n) }
    elsif arg.nil?
      my_each { |n| return true if n }
    elsif arg.is_a?(Regexp)
      my_each { |n| return true if arg.match(n) }
    elsif arg.is_a?(Integer) || arg.is_a?(String)
      my_each { |n| return true if n == arg }
    else
      my_each { |n| return true if n.is_a?(arg) }
    end
    false
  end
end

# rubocop:enable all
