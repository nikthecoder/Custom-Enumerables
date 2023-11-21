module CustomEnumerable
    def custom_each
      for custom_value in self
        yield(custom_value)
      end
      self
    end
  
    def custom_each_with_index
      for custom_i in 0...self.length
        yield(self[custom_i], custom_i)
      end
      self
    end
  
    def custom_select
      result_array = []
      self.custom_each do |custom_item|
        result_array << custom_item if yield(custom_item)
      end
      result_array
    end
  
    def custom_all?
      self.custom_each { |custom_value| return false unless yield(custom_value) }
      true
    end
  
    def custom_any?
      self.custom_each { |custom_value| return true if yield(custom_value) }
    end
  
    def custom_none?
      self.custom_each { |custom_value| return false if yield(custom_value) }
      true
    end
  
    def custom_count(custom_arg = nil)
      count = 0
      if custom_arg.nil? && block_given?
        self.custom_each { |custom_value| count += 1 if yield(custom_value) }
      elsif custom_arg.nil?
        self.custom_each { count += 1 }
      else
        self.custom_each { |custom_value| count += 1 if custom_value == custom_arg }
      end
      count
    end
  
    def custom_map
      result_array = []
      self.custom_each { |custom_value| result_array << yield(custom_value) }
      result_array
    end
  
    def custom_inject
      current = nil
      self.custom_each do |custom_value|
        current = if current.nil?
                    custom_value
                  else
                    yield(current, custom_value)
                  end
      end
      current
    end
  end
  
  custom_results = []
  # Calling custom_each
  custom_results << [1, 2, 3, 4].custom_each { |custom_num| puts custom_num.to_s }
  
  # Calling custom_each_with_index
  custom_results << Hash.new
  %w[custom_cat custom_dog custom_wombat].custom_each_with_index { |custom_item, custom_index| custom_results[1][custom_item] = custom_index }
  
  # Calling custom_select
  custom_results << [1, 2, 3, 4, 5].custom_select { |custom_num| custom_num.even? }
  
  # Calling custom_all?
  custom_results << %w[custom_ant custom_bear custom_cat].custom_all? { |custom_word| custom_word.length >= 3 }
  
  # Calling custom_any?
  custom_results << %w[custom_ant custom_bear custom_cat].custom_any? { |custom_word| custom_word.length >= 3 }
  
  # Calling custom_none?
  custom_results << %w[custom_ant custom_bear custom_cat].custom_none? { |custom_word| custom_word.length >= 4 }
  
  # Calling custom_count
  custom_array = [1, 2, 4, 2]
  custom_results << custom_array.custom_count
  custom_results << custom_array.custom_count(2)
  custom_results << custom_array.custom_count { |custom_x| custom_x % 2 == 0 }
  
  # Calling custom_map
  custom_results << (1..4).custom_map { |custom_i| custom_i * custom_i }
  
  # Calling custom_inject
  custom_results << (5..10).custom_inject { |custom_sum, custom_n| custom_sum + custom_n }
  custom_results << (5..10).custom_inject { |custom_product, custom_n| custom_product * custom_n }
  custom_results << %w[custom_cat custom_sheep custom_bear].custom_inject do |custom_memo, custom_word|
    custom_memo.length > custom_word.length ? custom_memo : custom_word
  end
  
  custom_results.custom_each do |custom_value|
    print custom_value
    puts
  end
  