require 'money'
require 'monetize'

Money.use_i18n = false

class Minikick
	class Project

		attr_reader :name

		def initialize(name, amount)
			@name = validate_name(name)
			@amount = validate_amount(amount).to_money
		end

		def amount
			return @amount.format(
				no_cents_if_whole: true,
				thousands_separator: false,
				symbol: false
			)
		end


		private


		def validate_name(name)
			validate_name_characters(name)
			validate_name_length(name)

			return name
		end

		def validate_name_characters(name)
			invalid_character_error_message = 'Project name may only use alphanumeric characters, underscores, and dashes.'
			invalid_characters = name.scan(/[^\w-]/)

			raise ArgumentError, invalid_character_error_message unless invalid_characters.empty?

			return name
		end

		def validate_name_length(name)
			invalid_length_error_message = 'Project name must be between 4 and 20 characters.'

			raise ArgumentError, invalid_length_error_message unless name.length >= 4 and name.length <= 20

			return name
		end

		def validate_amount(amount)
			invalid_amount_message = 'Project amount must not contain the "$" character.'

			raise ArgumentError, invalid_amount_message if amount.include?('$')

			return amount
		end

	end
end
