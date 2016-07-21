# Minikick

Mini Kickstarter, per the specification [here](https://gist.github.com/ktheory/3c28ba04f4064fd9734f).

## Installation

Clone the repo from [Github](https://github.com/macroscopicentric/minikick). Then install dependencies:

	$ bundle install

## Usage

From the same directory, execute the following line to see the help menu:

	$ bundle exec bin/minikick

There are four commands: `project`, `back`, `list`, and `backer`.

	$ bundle exec bin/minikick project [project name] [project amount]
	# creates a new project with a target amount
	$ bundle exec bin/minikick back [backer] [project] [credit card] [backing amount]
	# user backs a project at the given amount
	$ bundle exec bin/minikick list [project]
	# lists the users who have backed the project and how close it is
	# to being fully funded
	$ bundle exec bin/minikick backer [backer]
	# lists the projects a user has backed

## Next Steps:

(Including some things that aren't in the specification but would improve usability.)
- Back with a database instead of serialization.
- Create a separate credit card class.
- Create a generic base class for both projects and users to inherit from.
