require_relative '../spec_helper'

describe 'MiniKick::Project' do

	let(:default_project_name) { 'Fancy_Cooler' }
	let(:default_project_amount) { '1000' }

	it 'can create a new project with a name and amount' do
		new_project = Minikick::Project.new(default_project_name, default_project_amount)

		expect(new_project.name).to eq(default_project_name)
		expect(new_project.amount).to eq(default_project_amount)
	end

	it 'raises an ArgumentError if a project name contains invalid characters' do
		invalid_character_error_message = 'Project name may only use alphanumeric characters, underscores, and dashes.'
		
		expect { Minikick::Project.new('Fancy.Cooler', default_project_amount) }.to raise_error(ArgumentError, invalid_character_error_message)
	end

	it 'raises an ArgumentError if a project name is less than 4 characters or more than 20' do
		invalid_length_error_message = 'Project name must be between 4 and 20 characters.'
		
		expect { Minikick::Project.new('Fan', default_project_amount) }.to raise_error(ArgumentError, invalid_length_error_message)
		expect { Minikick::Project.new('The_Fanciest_Of_Coolers', default_project_amount) }.to raise_error(ArgumentError, invalid_length_error_message)
	end

	it 'allows both dollars and cents in the project amount' do
		project_amount = '1000.99'
		new_project = Minikick::Project.new(default_project_name, project_amount)

		expect(new_project.amount).to eq(project_amount)
	end

	it 'raises an ArgumentError if a project amount contains "$"' do
		project_amount = '$1000'
		invalid_amount_message = 'Project amount must not contain the "$" character.'

		expect { Minikick::Project.new(default_project_name, project_amount) }.to raise_error(ArgumentError, invalid_amount_message)
	end

end
