class WR_TCC_EXCEPTION

inherit
        DEVELOPER_EXCEPTION

create
        make

feature {NONE}
	-- Initializaton

	make (a_code: INTEGER)
		do
			code := a_code
			set_message ("TCC return code " + code)
	end

feature
	-- Access

	code: INTEGER

end
