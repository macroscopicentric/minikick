require_relative '../spec_helper'

describe 'Minikick::User' do

	before(:each) do
		Minikick::User.credit_cards.clear
	end

	let(:default_credit_card) { '4111111111111111' }
	let(:default_project) { 'LightSail' }
	let(:default_amount) { '1000' }

	context 'making a new user' do

		it 'can create a new user with a name and credit card' do
			user_name = 'Grace_Hopper'

			new_user = Minikick::User.new(user_name, default_credit_card)

			expect(new_user.name).to eq(user_name)
			expect(new_user.credit_card).to eq(default_credit_card)
		end

		it 'raises an error if user name contains invalid characters' do
			invalid_character_error_message = 'User name may only use alphanumeric characters, underscores, and dashes.'

			expect { Minikick::User.new('Margaret Hamilton', default_credit_card) }
				.to raise_error(invalid_character_error_message)
		end

		it 'raises an error if user name is less than 4 characters or more than 20' do
			invalid_length_error_message = 'User name must be between 4 and 20 characters.'

			expect { Minikick::User.new('Ada', default_credit_card) }
				.to raise_error(invalid_length_error_message)
			expect { Minikick::User.new('Evelyn_Boyd_Granville', default_credit_card) }
				.to raise_error(invalid_length_error_message)
		end

		it 'raises an error if the credit card number is invalid' do
			invalid_credit_card_message = 'Credit card number is invalid.'

			expect { Minikick::User.new('Radia_Perlman', '1111111111111111') }
				.to raise_error(invalid_credit_card_message)
		end

		it 'raises an error if the credit card number has already been used' do
			used_credit_card_message = 'Credit card number has already been added by another user.'

			new_user = Minikick::User.new('Mavis_Batey', default_credit_card)
			expect { Minikick::User.new('Jean_Bartik', default_credit_card) }
				.to raise_error(used_credit_card_message)
		end

	end

	context '#add_project_for_amount' do

		let(:user) do
			Minikick::User.new('Lynn_Conway', default_credit_card)
		end

		it 'allows both dollars and cents in the backing amount' do
			backing_amount = '1000.99'
			user.add_project_for_amount(default_project, backing_amount)

			expect(user.amount_backed_for(default_project)).to eq(backing_amount)
		end

		it 'raises an error if the backing amount contains "$"' do
			backing_amount = '$1000'
			invalid_amount_message = 'Backing amount must not contain the "$" character.'

			expect { user.add_project_for_amount(default_project, backing_amount) }
				.to raise_error(invalid_amount_message)
		end

	end

	context "#backed_projects" do

		let(:first_project_name) { default_project }
		let(:first_project_amount) { '50' }
		let(:second_project_name) { 'Exploding_Kittens' }
		let(:second_project_amount) { '35' }

		let(:user) do
			user = Minikick::User.new('Adele_Goldberg', default_credit_card)
			user.add_project_for_amount(default_project, '50')
			user.add_project_for_amount('Exploding_Kittens', '35')
			user
		end

		it 'returns all backed projects and their amounts' do
			backed_projects = user.backed_projects

			expect(backed_projects.length).to eq(2)
			expect(backed_projects).to include(first_project_name => first_project_amount)
			expect(backed_projects).to include(second_project_name => second_project_amount)
		end

	end

end
