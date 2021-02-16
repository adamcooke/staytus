# Staytus Maintenances API

The maintenances API allows you to access maintenances that are present in your Staytus site.

## Listing all issues

```text
/api/v1/maintenances/all
```

This method accepts no parameters and will return an array of
all maintenances. The method will return an array of service objects affected by that maintenance.

## Listing all upcoming issues

```text
/api/v1/maintenances/upcoming
```

This method accepts no parameters and will return an array of maintenances that are due. The method will return an array of service objects affected by that maintenance.


## Retrieving individual maintenance details

```text
/api/v1/maintenances/info
```

* `maintenance` - the ID for the maintenance you wish to lookup

```javascript
{
    "id": 1,
    "title": "A title",
    "description": "A description.",
    "start_at": "2017-11-08T14:00:00.000Z",
    "finish_at": "2017-11-08T15:00:00.000Z",
    "length_in_minutes": 60,
    "created_at": "2017-11-07T13:38:22.000Z",
    "updated_at": "2017-11-07T13:43:37.000Z",
    "services": [
        {
            "id": 1,
            "name": "Web Application",
            "permalink": "web-application",
            "position": 1,
            "created_at": "2017-11-07T13:37:32.000Z",
            "updated_at": "2017-11-07T13:37:32.000Z",
            "status_id": 1,
            "description": null,
            "group_id": null
        }
    ],
    "updates": [
        {
            "id": 1,
            "maintenance_id": 1,
            "user_id": 1,
            "text": "We are still hard at work!",
            "created_at": "2017-11-07T13:43:37.000Z",
            "updated_at": "2017-11-07T13:43:37.000Z",
            "identifier": "b7783b8845bb",
            "notify": false
        }
    ]
}
```
