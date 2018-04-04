# Drop edition server

The Drop server edition that includes listening orders from twitter and race web interface.


## Install

``` bash
git clone git@github.com:Darkmira/drop-edition-server.git
cd drop-edition-server/

cp .env.dist .env
# Then set your variables (Twitter tokens, change secret api key)

make
```


## Usage

Once installed, you are now listening to tweets destined for the robots.
But no orders will be sent to robots, until you start the race:

``` bash
make race_start
```

It will trigger a clock tick every N seconds (default to 20),
and send the most tweeted orders for every robots.

UI Links:

- http://0.0.0.0:15000/api/race Master API (prod mode) *to get race state*
- http://0.0.0.0:15000/index-dev.php/api/race Master API (debug mode)
- http://0.0.0.0:15000/index-dev.php/_profiler/ Master debug profiler (don't forget trailing slash) *to debug API calls on master*
- http://0.0.0.0:15001/ PHPMyAdmin to Master database (`root` / `root`) *to view raw data about the race*
- http://0.0.0.0:12001/ RabbitMQ management interface (`guest` / `guest`) *to view messages sent to robots*

Hosts:

- `ws://0.0.0.0:15002` Master websocket server *listen to real-time race events*
- `0.0.0.0:12000` RabbitMQ instance *listen to move orders sent to robots*


## License

This library is under [MIT License](LICENSE).
