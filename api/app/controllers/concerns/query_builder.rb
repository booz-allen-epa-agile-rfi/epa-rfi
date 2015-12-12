module QueryBuilder
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
  end

  def query_with(query, *options)
    options.each do |option|
      query = send("query_with_#{option}", query)
    end
    query
  end
end
