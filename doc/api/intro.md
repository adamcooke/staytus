# Staytus API

Staytus implements a [Moonrope](https://github.com/adamcooke/moonrope)
API.

## Authentication

To authenticate to the API you need to create an API token in the
Staytus admin area. Once created, you'll have a `token` and `secret`.
These should be sent with every request in the headers shown below.

* `X-Auth-Token` - should contain the token
* `X-Auth-Secret` - should contain the secret

## Parameters

To send parameters you should send a JSON hash containing your
parameters in the body of your request. Be sure to set the request
content type to `application/json`.

## Ruby Library

You can use any Moonrope-compatible API client to interact with
the API. The [Ruby client library](https://github.com/adamcooke/moonrope-client)
may be useful to you. If you use this, you can initialize the
connection as shown below:

```ruby
headers= {'X-Auth-Token' => 'your-token', 'X-Auth-Secret' => 'your-secret'}
api = MoonropeClient::Connection.new('status.yourapp.com', :headers => headers, :ssl => true)
response = api.services.set_status(:service => 'webapp', :status => 'minor-outage')
if response.success?
  puts "Status was updated successfully."
else
  puts "Status was not updated successfully."
end
```
