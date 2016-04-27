# ClassList

When analyzing an unfamiliar project, it can be useful to have a class hierarchy to hand. 

Classlist scans a set of Ruby files and prints out any classes declared with their hierarchy.

Note. This is a quick and dirty syntactic scan which does NOT take account of any module declarations or nested classes.

It is intended for use in investigating a (possibly non-functioning) code base.


## Installation


Or it as:

    $ gem install class_list

## Usage

$ class_list file1.rb file2.rb ...

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/class_list.

