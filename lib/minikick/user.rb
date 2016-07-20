require 'luhn'

module Minikick
	class User

		class << self; attr_accessor :credit_cards end
		@credit_cards ||= Array.new

		attr_reader :name
		attr_reader :credit_card

		def initialize(name, credit_card)
			@name = validate_name(name)
			@credit_card = validate_credit_card(credit_card)
			self.class.credit_cards.push(@credit_card)

			@backed_projects = {}
		end

		def add_project_for_amount(project, amount)
			@backed_projects[project] = validate_amount(amount).to_money
		end

		def amount_backed_for(project)
			return format_amount(@backed_projects[project])
		end

		def backed_projects
			return @backed_projects.each_with_object({}) do |(project, amount), formatted_hash|
				formatted_hash[project] = format_amount(amount)
			end
		end


		private


		def format_amount(amount)
			return amount.format(
				no_cents_if_whole: true,
				thousands_separator: false,
				symbol: false
			)
		end

		def validate_name(name)
			validate_name_characters(name)
			validate_name_length(name)

			return name
		end

		def validate_name_characters(name)
			invalid_character_error_message = 'User name may only use alphanumeric characters, underscores, and dashes.'
			invalid_characters = name.scan(/[^\w-]/)

			raise ArgumentError, invalid_character_error_message unless invalid_characters.empty?

			return name
		end

		def validate_name_length(name)
			invalid_length_error_message = 'User name must be between 4 and 20 characters.'

			raise ArgumentError, invalid_length_error_message unless name.length >= 4 and name.length <= 20

			return name
		end

		def validate_credit_card(credit_card)
			validate_card_number(credit_card)
			validate_unique_card(credit_card)

			return credit_card
		end

		def validate_card_number(credit_card)
			invalid_card_number_message = 'Credit card number is invalid.'

			raise ArgumentError, invalid_card_number_message unless Luhn.valid?(credit_card)

			return credit_card
		end

		def validate_unique_card(credit_card)
			already_used_card_number_message = 'Credit card number has already been added by another user.'

			raise ArgumentError, already_used_card_number_message if self.class.credit_cards.include?(credit_card)

			return credit_card
		end

		def validate_amount(amount)
			invalid_amount_message = 'Backing amount must not contain the "$" character.'

			raise ArgumentError, invalid_amount_message if amount.include?('$')

			return amount
		end

	end
end
