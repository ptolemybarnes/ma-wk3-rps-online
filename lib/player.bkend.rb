class Player
  attr_accessor :type, :name, :choice, :score

  def initialize(options = {})
    @name   = options[:name]
    @type   = options[:type]
    @score  = 0
    @choice = nil
  end

  def submit_choice
    submit = choice
    choice = nil
    submit
  end

  def ready?
    choice ? true : false
  end

end