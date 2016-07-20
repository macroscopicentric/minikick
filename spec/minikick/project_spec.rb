require_relative '../spec_helper'

describe 'Minikick::Project' do

	let(:default_project_name) { 'Fancy_Cooler' }
	let(:default_project_amount) { '1000' }

	context 'making a new project' do

		it 'can create a new project with a name and amount' do
			new_project = Minikick::Project.new(default_project_name, default_project_amount)

			expect(new_project.name).to eq(default_project_name)
			expect(new_project.amount).to eq(default_project_amount)
		end

		it 'allows both dollars and cents in the project amount' do
			project_amount = '1000.99'
			new_project = Minikick::Project.new(default_project_name, project_amount)

			expect(new_project.amount).to eq(project_amount)
		end

		it 'raises an error if a project name contains invalid characters' do
			invalid_character_error_message = 'Project name may only use alphanumeric characters, underscores, and dashes.'
			
			expect { Minikick::Project.new('Fancy.Cooler', default_project_amount) }
				.to raise_error(invalid_character_error_message)
		end

		it 'raises an error if a project name is less than 4 characters or more than 20' do
			invalid_length_error_message = 'Project name must be between 4 and 20 characters.'
			
			expect { Minikick::Project.new('LoL', default_project_amount) }
				.to raise_error(invalid_length_error_message)
			expect { Minikick::Project.new('Ladies_of_Literature_Volume_2', default_project_amount) }
				.to raise_error(invalid_length_error_message)
		end

		it 'raises an error if the project amount contains "$"' do
			project_amount = '$1000'
			invalid_amount_message = 'Project amount must not contain the "$" character.'

			expect { Minikick::Project.new(default_project_name, project_amount) }
				.to raise_error(invalid_amount_message)
		end

	end

	context "listing a project's progress" do

		let(:first_backer) { 'Fran_Allen' }
		let(:first_amount) { '300'}
		let(:second_backer) { 'Shafi_Goldwasser' }
		let(:second_amount) { '200' }

		let(:project) do 
			project = Minikick::Project.new(default_project_name, default_project_amount)
			project.add_backer_and_amount(first_backer, first_amount)
			project.add_backer_and_amount(second_backer, second_amount)
			project
		end

		it 'knows its own backers and backed amounts' do
			expect(project.backers_and_amounts).to include(first_backer => first_amount)
			expect(project.backers_and_amounts).to include(second_backer => second_amount)
		end

		it 'knows how much funding it still needs' do
			funding_needed = '500'

			expect(project.funding_needed).to eq(funding_needed)
		end

		context '#funded?' do

			it 'returns false when the project is not fully funded' do
				expect(project.funded?).to be_falsy
			end

			it 'returns true when the project is fully funded' do
				project.add_backer_and_amount('Frances_Spence', '500')

				expect(project.funded?).to be_truthy
			end

		end

	end

end
