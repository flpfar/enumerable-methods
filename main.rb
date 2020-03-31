# frozen_string_literal: true

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
end
