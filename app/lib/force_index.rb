class << ActiveRecord::Base
  def force_index(index)
    from("#{table_name} FORCE INDEX(#{index})")
  end
end