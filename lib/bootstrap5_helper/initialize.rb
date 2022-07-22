module Bootstrap5Helper # :nodoc:
  # Naming convention used as to not pollute views where the module is
  # included.  @config is a common instance variable name.  We don't want
  # to risk overriding another developers variable.
  #
  @_bs5h_config = Configuration.new

  class << self
    # Simple interface for exposing the configuration object.
    #
    # @return [Bootstrap5Helper::Configuration]
    #
    def config
      yield @_bs5h_config if block_given?

      @_bs5h_config
    end
  end
end
