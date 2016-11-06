class Recipe

  attr_reader :name, :id, :label, :recipe, :image

  def initialize(name, id, options = {} )
    # Commented out because there's no way I'd be able to remember
    # all this live.
    # @purpose = options[:purpose]
    # @is_archived = options[:is_archived]
    # @is_general = options[:is_archived]
    # @members = options[:members]
    @name = name
    @id = id
  end

  # Send a message to this slack channel
  # Returns the data from the Slack server's response
  def show
  end

  # Create a class-level instance variable.
  # Musch more likely to work as expected than a class variable
  # See http://www.railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/
  class << self
    attr_reader :channels
  end

  # class << self, an instance variable we have access to  "Channel.channels", another way of writing a function self.all

  # Return a memoized set of all channels
  def self.all
    SlackApiWrapper.listchannels
  end

  # Foreget all memoized values
  def self.reset
  end

  # Return either the first (probably only) channel matching
  # the given name, or nil.
  def self.by_name(name)
    matches = all.select do |c|
      c.name == name
    end
    return matches.first
  end

  # Return either the first (probably only) channel matching
  # the given ID, or nil.
  def self.by_id(id)
  end
end