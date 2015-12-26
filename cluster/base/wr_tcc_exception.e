class WR_TCC_EXCEPTION

inherit
        EXCEPTION

create
        make

feature {NONE}
	-- Initializaton

	make (a_code: INTEGER)
		require
			a_not_void_code: a_code /= Void
		do
			the_code := a_code
	end

feature
	-- Access

	the_code: INTEGER

end
