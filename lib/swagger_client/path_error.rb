# The error to be risen in case used path is not defined by a specification
class SwaggerClient::PathError < NoMethodError
  # Used path relative to the `basePath` from swagger schema
  # @return [String]
  attr_reader :path

  private

  def initialize(path, part)
    @path = "#{path}/#{part}".tr("//", "/")
    super "Path #{@path} is not defined"
  end
end
