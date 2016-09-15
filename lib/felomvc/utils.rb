class String
  #Converts to snake case, Flow from controller to view
  def to_snake_case
    self.gsub("::", "/"). #Replace :: to /
    gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2'). #FOOBar = >foo_bar
    gsub(/([a-z\d])([A-Z])/, '\1_\2'). #FO86OBar => foo86_o_bar
    tr("-", "_"). #Replace any - with _
    downcase
  end

  #Converts to camel case, Flow from route to controller
  def to_camel_case
    return self if self !~ /_/ && self =~ /[A-Z]+.*/
    split('_').map { |str| str.capitalize }.join # hi_there => HiThere
  end
end