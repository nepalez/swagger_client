# The node of the AST describes a path relative to the schema's basePath
#
# This is a MUTABLE structure, updated by methods [#add_subpath]
# and [#add_request] during building the AST.
#
# It refers to children [#paths] and [#requests]
#
class SwaggerClient::Path
  attr_reader :name, :regexp

  # @param [String] name   The full relative name (`users/{id}`)
  # @param [Regexp] regexp The matcher for the chunk added to full path (`/\A\d+\z/`)
  def initialize(name, regexp)
    @name     = name
    @regexp   = regexp
    @subpaths = []
    @requests = {}
  end

  # Adds a subpath to the current path
  # @param  (see #initialize)
  # @return [Namespace]
  def add_subpath(name, regexp)
    @subpaths << self.class.new(name, regexp)
  end

  # Finds nested path by a part
  # @param  [#to_s] part
  # @return [SwaggerClient::Path] if the path is found
  # @raise  [SwaggerClient::PathError] if the path is absent
  def subpath(part)
    @subpaths.find { |item| part.to_s[item.regexp] }.tap do |node|
      fail SwaggerClient::PathError.new(name, part) unless node
    end
  end

  private

  def clone(&block)
    dup.tap { |item| item.instance_eval(&block) }
  end
end
