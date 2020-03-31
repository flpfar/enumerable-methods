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
end
