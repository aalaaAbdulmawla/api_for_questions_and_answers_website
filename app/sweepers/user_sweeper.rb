class UserSweeper < ActionController::Caching::Sweeper
	observe User

	def sweep(user)
	  expire_page users_path
   	expire_page users_path(user)
	end

	alias_method :after_update, :sweep
  alias_method :after_create, :sweep
  alias_method :after_destroy, :sweep

end