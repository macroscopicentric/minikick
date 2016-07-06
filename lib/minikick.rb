require 'money'
require 'monetize'

require "minikick/version"

Money.use_i18n = false

class Project

	attr_reader :name

	def initialize(name, amount)
		@name = name
		@amount = amount.to_money
	end

	def amount
		return @amount.format(
			no_cents_if_whole: true,
			thousands_separator: false,
			symbol: false
		)
	end

end
