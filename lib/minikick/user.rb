class Minikick
	class User

		attr_reader :name
		attr_reader :credit_card

		def initialize(name, credit_card, project, backing_amount)
			@name = name
			@credit_card = credit_card
			@backed_projects[project] = backing_amount
		end

	end
end
