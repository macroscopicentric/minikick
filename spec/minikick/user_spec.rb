require_relative '../spec_helper'

describe 'Minikick::User' do

	let(:default_credit_card) { '4111111111111111' }
	let(:default_project) { 'LightSail' }
	let(:default_amount) { '1000' }

	it 'can create a new user with a name and credit card' do
		user_name = 'Grace_Hopper'

		new_user = Minikick::User.new(user_name, default_credit_card, default_project, default_amount)

		expect(new_user.name).to eq(user_name)
		expect(new_user.credit_card).to eq(default_credit_card)
	end

	it 'allows both dollars and cents in the backing amount' do
		backing_amount = '1000.99'
		new_project = Minikick::User.new('Lynn_Conway', default_credit_card, default_project, backing_amount)

		expect(new_project.amount).to eq(backing_amount)
	end

	it 'raises an error if a project name contains invalid characters' do
		invalid_character_error_message = 'User name may only use alphanumeric characters, underscores, and dashes.'
		
		expect { Minikick::User.new('Margaret Hamilton', default_credit_card, default_project, default_amount) }
			.to raise_error(invalid_character_error_message)
	end

	it 'raises an error if a project name is less than 4 characters or more than 20' do
		invalid_length_error_message = 'User name must be between 4 and 20 characters.'
		
		expect { Minikick::User.new('Ada', default_credit_card, default_project, default_amount) }
			.to raise_error(invalid_length_error_message)
		expect { Minikick::User.new('Evelyn_Boyd_Granville', default_credit_card, default_project, default_amount) }
			.to raise_error(invalid_length_error_message)
	end

	it 'raises an error if the credit card number is invalid' do
		invalid_credit_card_message = 'Credit card number is invalid.'

		expect { Minikick::User.new('Radia_Perlman', '1111111111111111', default_project, default_amount) }
			.to raise_error(invalid_credit_card_message)
	end

	it 'raises an error if the credit card number has already been used' do
		used_credit_card_message = 'Credit card number has already been added by another user.'

		new_user = Minikick::User.new('Mavis_Batey', default_credit_card, default_project, default_amount)
		expect { Minikick::User.new('Jean_Bartik', default_credit_card, default_project, default_amount) }
			.to raise_error(used_credit_card_message)
	end

	it 'raises an error if the backing amount contains "$"' do
		backing_amount = '$1000'
		invalid_amount_message = 'Project amount must not contain the "$" character.'

		expect { Minikick::User.new('Barbara_Liskov', default_credit_card, default_project, backing_amount) }
			.to raise_error(invalid_amount_message)
	end

end
