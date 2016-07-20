#!/usr/bin/env ruby
require 'json'

class Minikick

	require 'minikick/project'
	require 'minikick/user'

	FILENAME = 'minikick_data.txt'

	attr_reader :users
	attr_reader :projects

	def initialize(filename=FILENAME)
		@filename = filename
		@users = {}
		@projects = {}
	end

	def self.save(filename=FILENAME)
		File.open(filename, 'wb') {|f| f.write(Marshal.dump(self)) }
	end

	def self.load(filename=FILENAME)
		return Marshal.load(File.binread(filename))
	end

	def self.load_or_new(filename=FILENAME)
		File.exists?(filename) ? minikick = self.load(filename) : minikick = self.new
		return minikick
	end

	def add_project(project_name, target_amount)
		project = Minikick::Project.new(project_name, target_amount)
		@projects[project_name] = project

		success_message = "Added #{project.name} with a target of $#{project.amount}"
		return success_message
	end

	def back_project(user_name, project_name, credit_card_number, backing_amount)
		user = Minikick::User.new(user_name, credit_card_number)
		@users[user_name] = user
		user.add_project_for_amount(project_name, backing_amount)

		project = @projects[project_name]
		project.add_backer_and_amount(user_name, backing_amount)

		success_message = "#{user.name} backed project #{project.name} for $#{backing_amount}."
		return success_message
	end

	def list_backers(project_name)
		project = @projects[project_name]

		info = project.backers_and_amounts.map do |backer, amount|
			"-- #{backer} backed for $#{amount}."
		end

		successful_backing = "#{project.name} is successful!"
		not_yet_backed = "#{project.name} needs $#{project.funding_needed} more dollars to be successful."
		project.funded? ? info << successful_backing : info << not_yet_backed

		return info
	end

	def list_projects_backed(user_name)
		user = @users[user_name]

		info = user.backed_projects.map do |project, amount|
			"-- Backed #{project} for $#{amount}"
		end

		return info
	end

end
