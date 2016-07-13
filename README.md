# [WIP] SwaggerClient

The opinionated HTTP client to a remote API, initialized by its [Swagger specification][swagger].

## Setup

The library is available as a gem `swagger_client`.

## Synopsis

Initialize a client using a swagger specification:

```ruby
require 'swagger_client'

client = SwaggerClient.new 'path_to_schema.yml'
```

Suppose the action `PUT /api/v1/users/{id}` is defined by the specification. Use path chaining to provide a response:

```ruby
response = client.api.v1.users[1].put! name: 'Joe', token: 'foobar'

# Or using the alternative syntax:
response = client[:api][:v1][:users][1].put! name: 'Joe', token: 'foobar'
```

A "bang" method sends a corresponding request to the server (any other method is treated as a part of request path).

Because Swagger [explicitly defines a location][location] for every named parameter, you don't need to separate body, query and header in a request. The client will do it by its own.

After validation, the request is sent to the remote server via [Net::HTTP][net-http] underlying client.

The response is validated by specification, and mapped to the nested hash with symbolized keys:

```ruby
response = client.api.v1.users[1].put! name: 'Joe', token: 'foobar'
# => { success: true, user: { id: 1, name: 'Joe', age: 10, preferences: ['ice-cream', 'lemonade'] } }
```

## More Details

### Supported Schema Formats

You can instantiate a client with either a hash, or a path to file containing valid YAML or JSON:

```ruby
client = SwaggerClient.new 'path_to_schema.yml'
client = SwaggerClient.new 'path_to_schema.json'
client = SwaggerClient.new swagger: '2.0', info: { title: 'Sweety API', ... }, ...
```

### Schema Customization

The common pattern is using different settins for test, development, production, and other environments.

For this reason you can customize any part of the [swagger schema][schema] dynamically during the initialization:

```ruby
client = SwaggerClient.new 'path_to_schema.yml',
                           host:     'https://test_api.com',
                           basePath: 'v1/users'
```

### Exceptions

The client provides validation for both the request and response, and raises the following exceptions:

* `SwaggerClient::PathError` (subclasses `NoMethodError`) - when a path mismatches the specification.

  The exception supports methods `#message` and `#path` for debugging.

* `SwaggerClient::HttpMethodError` (subclasses `NoMethodError`) - when a request method (`put!`, `post!` etc.) is not defined for provided path.

  The exception supports methods `#message`, `#path` and `#http_method`.

* `SwaggerClient::RequestError` (subclasses `ArgumentError`) - when a request arguments mismatches the specification.

  The exception supports methods `#message`, and `#request` (see [rack request][rack-request]).

* `SwaggerClient::StatusError` (subclasses `RuntimeError`) - in case a server responded with http status code 400+.

  The exception supports methods `#message`, `#status`, `#request`  (see [rack request][rack-request]), and `#response` (see [rack response][rack-response])

* `SwaggerClient::ResponseError` (subclasses `TypeError`) - when a server returned a response that mismatches the specification.

  The exception supports methods `#message`, `#request`  (see [rack request][rack-request]), and `#response` (see [rack response][rack-response])

## Compatibility

Tested under [rubies compatible to 2.2+](.travis.yml).

Uses [RSpec][rspec] 3.0+ for testing.

## Contributing

* [Fork the project](https://github.com/evilmartians/evil-client)
* Create your feature branch (`git checkout -b my-new-feature`)
* Add tests for it
* Commit your changes (`git commit -am 'Add some feature'`)
* Push to the branch (`git push origin my-new-feature`)
* Create a new Pull Request

## License

See the [MIT LICENSE](LICENSE).

[location]: http://swagger.io/specification/#parameterIn
[net-http]: http://ruby-doc.org/stdlib-2.3.1/libdoc/net/http/rdoc/Net/HTTP.html
[rack-request]: http://www.rubydoc.info/gems/rack/Rack/Request
[rack-response]: http://www.rubydoc.info/gems/rack/Rack/Response
[rspec]: http://rspec.org
[schema]: http://swagger.io/specification/#swaggerObject
[swagger]: http://swagger.io
