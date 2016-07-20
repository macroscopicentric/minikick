require 'spec_helper'

describe 'Minikick' do

	before(:each) do
		Minikick::User.credit_cards.clear
	end

	let(:default_project_name) { 'fun_new_project' }
	let(:default_project_amount) { '500' }
	let(:default_user_name) { 'Lillian_Schwartz' }
	let(:default_credit_card) { '4111111111111111' }
	let(:default_backing_amount) { '20' }

	it 'can add a new project' do
		minikick = Minikick.new

		expect { minikick.add_project(default_project_name, default_project_amount) }.
			to change { minikick.projects.length }.by( 1 )
		expect( minikick.projects[default_project_name] ).to be_a( Minikick::Project )
	end

	it 'can back a project' do
		minikick = Minikick.new
		minikick.add_project(default_project_name, default_project_amount)

		expect { minikick.back_project(default_user_name, default_project_name, default_credit_card, default_backing_amount) }.
			to change { minikick.users.length }.by( 1 )
		expect( minikick.users[default_user_name] ).to be_a( Minikick::User )
	end

	it 'can list the backers of a project' do
		minikick = Minikick.new
		minikick.add_project(default_project_name, default_project_amount)
		minikick.back_project(default_user_name, default_project_name, default_credit_card, default_backing_amount)

		response = minikick.list_backers(default_project_name)

		expect( response ).to be_an( Array )
		expect( response.length ).to eq( 2 )
		expect( response.first ).to include( default_user_name )
		expect( response.first ).to include( default_backing_amount )
		expect( response.last ).to include( default_project_name )
	end

	it 'knows when a project has been successfully backed' do
		minikick = Minikick.new
		minikick.add_project(default_project_name, default_project_amount)
		minikick.back_project(default_user_name, default_project_name, default_credit_card, default_project_amount)

		response = minikick.list_backers(default_project_name)

		expect( response ).to be_an( Array )
		expect( response.length ).to eq( 2 )
		expect( response.first ).to include( default_user_name )
		expect( response.first ).to include( default_project_amount )
		expect( response.last ).to include( 'successful' )
	end

	it 'can list the projects a user has backed' do
		minikick = Minikick.new
		minikick.add_project(default_project_name, default_project_amount)
		minikick.back_project(default_user_name, default_project_name, default_credit_card, default_backing_amount)

		response = minikick.list_projects_backed(default_user_name)

		expect( response ).to be_an( Array )
		expect( response.length ).to eq( 1 )
		expect( response.first ).to include( default_project_name )
		expect( response.first ).to include( default_backing_amount )
	end
	
end
