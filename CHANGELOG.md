# Changelog
1.1.0
-----
* Include in `ActiveSupport::HashWithIndifferentAccess`, which also expands Rails compatibility down to version 3.2.
* Expand testing with `Appraisal` gem. Test against Rails 3.2, 4.2, and 5.1, and Ruby >= 1.9.3
* Consolidate all methods into `Allowable` module, remove `Allowable::Allow` and `Allowable::Forbid`

1.0.2
-----
* Match array values e.g. `{ key: ['val_one', 'val_two'] }.forbid(key: ['val_one', 'val_two']) # => {}` TODO: Slows down benchmarked performance of `#allow`, need to figure out why

1.0.1
-----
* Relax Ruby version restriction. Core module should work with any Ruby. Rails < 4.2.0 may experience issues initializing the plugin.
