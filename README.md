# README

### Built With:

* [![Ruby]][Ruby-url] **3.1.1**
* [![Rails]][Rails-url] **7.0.4**
* [![Postgresql]][Postgresql-url]

### Installation

1. Clone the repo:
   ```bash
   git clone git@github.com:C-V-L/tea_subscription.git
   ```

2. Install gems:
   ```bash
   bundle install
   ```

3. To establish the database, run:
   ```bash
   rails db:create
   ```

4. Since this is the back-end repository, a database migration is also necessary, run:
   ```bash
   rails db:migrate
   ```
5. Seed the database with a Customer and Tea, run:
   ```bash
   rails db:seed
   ```
<br>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<br>

### Testing with RSpec

Once `tea_subscription` is correctly installed, run tests locally to ensure the repository works as intended.

<br>

  To test the entire RSpec suite, run:
   ```bash
   bundle exec rspec
   ```

<br>

All tests should be passing if the installation was successful. 

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<br>
## Available Endpoints
- This API can be called locally using a program like [Postman](https://www.postman.com).

- *Note:* Necessary parameters marked with {}

<br>

### __Subscription__ __Endpoints__

<br>
1. Create a New Customer Subscription:
<br>

```bash
POST '/api/v1/customer/:id/subscriptions'
```

Payload must be passed as a raw JSON payload:
```bash
{
    "tea_id": 1,
    "price": 9.5,
    "frequency": "weekly"
}
```

Response:
```bash
{
    "data": {
        "id": "4",
        "type": "subscription",
        "attributes": {
            "customer_id": 1,
            "tea_id": 1,
            "price": 9.5,
            "status": "active",
            "frequency": "weekly"
        }
    }
}
```
<br>
2. Update a subscriptions status:
<br>

```bash
PATCH '/api/v1/customer/:id/subscriptions/:id'
```

Payload must be passed as a raw JSON payload:
```bash
{
    "status": "cancelled"
}
