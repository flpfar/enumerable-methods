# frozen_string_literal: true

# Adding methods to Enumerable module
module Enumerable
  def my_each
    return to_enum unless block_given?

    object = self
    object.size.times do |n|
      yield object[n]
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    object = self
    object.size.times do |n|
      yield object[n], n
    end
  end

  def my_select
    return to_enum unless block_given?

    array = []
    object = self
    object.my_each do |n|
      array.push(n) if yield(n)
    end
    array
  end
end
