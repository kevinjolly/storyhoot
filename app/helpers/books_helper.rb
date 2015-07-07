module BooksHelper
	def author_info(id)
			User.find(id)
	end
end
