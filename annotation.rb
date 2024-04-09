attrs = { author_id: 1, publisher_id: 2, isbn: 3 }

class SearchCriteria1
  def self.hash_initializer(*attribute_names)
    define_method(:initialize) do |*args|
      data = args.first || {}
      attribute_names.each do |attribute_name|
        instance_variable_set("@#{attribute_name}", data[attribute_name])
      end
    end
  end

  hash_initializer :author_id, :publisher_id, :isbn
end

sc1 = SearchCriteria1.new(attrs)
sc1.instance_variables.each do |var|
  puts "#{var} = #{sc1.instance_variable_get(var)}"
end

module CustomInitializers
  def hash_initializer(*attribute_names)
    define_method(:initialize) do |*args|
      data = args.first || {}
      attribute_names.each do |attribute_name|
        instance_variable_set("@#{attribute_name}", data[attribute_name])
      end
    end
  end
end

class SearchCriteria2
  extend CustomInitializers  # not include

  hash_initializer :author_id, :publisher_id, :isbn
end

sc2 = SearchCriteria2.new(attrs)
sc2.instance_variables.each do |var|
  puts "#{var} = #{sc2.instance_variable_get(var)}"
end