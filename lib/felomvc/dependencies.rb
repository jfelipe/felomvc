#Reopens Object class and creates the const_missing method to require the missing dependencie
class Object
  def self.const_missing(const)
    require const.to_s.to_snake_case
    Object.const_get(const)
  end
end