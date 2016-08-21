class QuestionSweeper < ActionController::Caching::Sweeper
	observe Question

	def sweep(question)
	  expire_page questions_path
   	expire_page questions_path(question)
	end

	alias_method :after_update, :sweep
  alias_method :after_create, :sweep
  alias_method :after_destroy, :sweep

end