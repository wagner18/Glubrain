class MemoCard

  PROPERTIES = [:id, :subject, :question, :answer, :image, :audio]
  PROPERTIES.each { |prop|
    attr_accessor prop
  }

  def initialize(hash = {})
    hash.each { |key, value|
     self.send(key.to_s + "=", value) 
    }
  end

end