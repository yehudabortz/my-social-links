# My Social Links
A one-page directory for all your social media links. Using Sinatra and Active Record a user can Sign Up / Sign In to their account and CREATE, READ, UPDATE and DELETE links from the dashboard. Users can also follow their friends to see what relevant links they are sharing.

## Installation

#### Clone this repository.

- Use Ruby Gem [bundler](https://bundler.io/) to install dependencies.

``` bash
gem install bundler
```
- Install required Ruby Gems.
``` bash
bundle install
```

- Use Rake to create sqlite3 database and required migrations.

```bash
rake db:migrate
```

- Use Rake to add seed data.
```bash
rake db:seed
```

- Use Shotgun to start server. 

```bash
shotgun
```
- Open a new tab in your browser.

``` bash
http://localhost:9393
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://github.com/yehudabortz/my-social-links/blob/main/LICENSE)