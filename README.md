# url-shortener

URL Shortener using Ruby on Rails.

## Run in production

### Using docker-compose

You can use the script `./bin/prepare-local-prod` :
- Create containers and volumes
- Initialize the Postgres database

By default, the host is `localhost`, you must change it to your domain/ip address, it is located in the 
`docker-compose.yml`.

```yaml
services:
  ...
  app:
    environment:
      - APP_HOST=sho.rt
```
