# Staytus Issues API

The issues API allows you to access and modify issues which
are present in your Staytus site.

## Listing all isues

```text
/api/v1/issues/all
```

This method accepts no parameters and will return an array of
all issues. The method will return an array of service objects
(see `issues/info` for an example) without the `updates` expansion.

## Retrieving individual issue details

```text
/api/v1/issues/info
```

* `issue` - the ID for the issue you wish to lookup

```javascript
{
  "id": 3,
  "title": "Network Connectivity Issues",
  "state": "monitoring",
  "identifier": "90f236ca-7bd7-4d01-a8e2-edcaf9de2a68",
  "created_at": "2015-07-14T12:25:47.000Z",
  "updated_at": "2015-07-14T12:50:47.000Z",
  "notify": false,
  "user": {
    "id": 1,
    "email_address": "admin@example.com",
    "name": "Admin User"
  },
  "service_status": {
    "id": 1,
    "name": "Operational",
    "permalink": "operational",
    "color": "2FCC66"
  },
  "updates": [
    {
      "id": 8,
      "state": "investigating",
      "text": "We're currently working with resolving a network issue which is affecting access to the Viaduct EU-West-1 network.",
      "identifier": "355b14a2deed",
      "created_at": "2015-07-14T12:25:47.000Z",
      "updated_at": "2015-07-14T12:50:47.000Z",
      "notify": false,
      "user": {
        "id": 1,
        "email_address": "admin@example.com",
        "name": "Admin User"
      },
      "service_status": {
        "id": 3,
        "name": "Partial Outage",
        "permalink": "partial-outage",
        "color": "E67E22"
      }
    },
    {
      "id": 9,
      "state": "identified",
      "text": "We've identified the issue and working to adjust our routing to route around the issue with an upstream provider.",
      "identifier": "aecb351f6ade",
      "created_at": "2015-07-14T12:30:47.000Z",
      "updated_at": "2015-07-14T12:50:47.000Z",
      "notify": false,
      "user": {
        "id": 1,
        "email_address": "admin@example.com",
        "name": "Admin User"
      },
      "service_status": null
    }
  ]
}
```
