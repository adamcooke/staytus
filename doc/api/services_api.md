# Staytus Services API

The services API allows you to access and modify services which
are present in your Staytus site.

## Listing all service statuses

```text
/api/v1/services/all
```

This method accepts not parameters and will return an array of
all services along with their statuses. The method will return
an array of service objects (see `services/info` for an example).

## Retrieving individual service details

```text
/api/v1/services/info
```

* `service` - the permalink for the service you wish to lookup

```javascript
{
  "id": 2,
  "name": "Developer API",
  "permalink": "developer-api",
  "position": 2,
  "description": "Our HTTP JSON API for application developers.",
  "created_at": "2015-02-25T21:37:36.000Z",
  "updated_at": "2015-02-25T21:49:09.000Z",
  "status": {
    "id": 1,
    "name": "Operational",
    "permalink": "operational",
    "color": "2FCC66",
    "status_type": "ok",
    "created_at": "2015-02-25T21:37:36.000Z",
    "updated_at": "2015-02-25T21:37:36.000Z"
  }
}
```

## Seting the status for a service

```text
/api/v1/services/set_status
```

* `service` - the permalink for the service you want to set
* `status` - the permalink of the status you want to set

This will return the service's details. `services/info` method.
