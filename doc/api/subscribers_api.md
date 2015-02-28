# Staytus Subscribers API

The subscribers API allows you to manage the people who have subscribed to
receive email updates when things occur on your status site.

## Getting information about a subscriber

```text
/api/v1/subscribers/info
```

* `email_address` - the email address to lookup
* `verification_token` - the verification token to lookup

Only one of these parameters is required.

```javascript
{
  "id": 9,
  "email_address": "blah@blah.com",
  "verification_token": "20274f8b-96df-4135-a6d3-ac10eb601b7f",
  "verified_at": null,
  "created_at": "2015-02-28T13:55:58.000Z",
  "updated_at": "2015-02-28T13:55:58.000Z"
}
```

## Adding a new subscriber

```text
/api/v1/subscribers/add
```

* `email_address` - the email address to add (required)
* `verified` - whether or not this is verified or not. By default, all addresses
  are not verified and must be verified by the user. To add an email address
  without requiring verification, set this variable to `1`.

## Verify a subscriber

```text
/api/v1/subscribers/verify
```

* `email_address` - the email address to verify (required)

## Send a verification email

```text
/api/v1/subscribers/send_verification_email
```

* `email_address` - the email address of the subscriber to send the verification
  message to. This must already have been added. (required)

## Delete a subscriber

```text
/api/v1/subscribers/delete
```

* `email_address` - the email address to delete (required)
