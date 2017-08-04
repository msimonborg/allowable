# Changelog
1.0.2
-----
* Match array values e.g. `{ key: ['val_one', 'val_two'] }.forbid(key: ['val_one', 'val_two']) # => {}` TODO: Slows down benchmarked performance of `#allow`, need to figure out why

1.0.1
-----
* Relax Ruby version restriction. Core module should work with any Ruby. Rails < 4.2.0 may experience issues initializing the plugin.
