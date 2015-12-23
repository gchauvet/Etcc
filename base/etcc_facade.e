note

	description:

		"Provide a facade interface to TinyCC library"

	copyright: "Copyright (c) 2015, Guillaume CHAUVET and others"
	license: "Eiffel Forum License 2"

class ETCC_FACADE

create make

feature

feature {NONE}

	make
		do
			internal := tcc_new
	end

feature {NONE}
	-- Context bindings

	internal: POINTER

	tcc_new : POINTER
		external
			"C signature use <libtcc.h>"
	end

	tcc_delete (data: POINTER)
		external
			"C signature use <libtcc.h>"
	end

	tcc_enable_debug (data: POINTER)
		external
			"C signature use <libtcc.h>"
	end

feature {NONE}
	-- Preprocessor bindings

	tcc_add_include_path (data: POINTER; pathname: STRING) : INTEGER
		external
			"C signature use <libtcc.h>"
	end

	tcc_add_include_sysinclude_path (data: POINTER; pathname: STRING) : INTEGER
		external
			"C signature use <libtcc.h>"
	end

	tcc_define_symbol (data: POINTER; symbol: STRING; value: STRING)
		external
			"C signature use <libtcc.h>"
	end

	tcc_undefine_symbol (data: POINTER; symbol: STRING)
		external
			"C signature use <libtcc.h>"
	end

feature {NONE}
	-- Compiling bindings

	tcc_add_file (data: POINTER; filename: STRING) : INTEGER
		external
			"C signature use <libtcc.h>"
	end

	tcc_compile_string (data: POINTER; content: STRING)
		external
			"C signature use <libtcc.h>"
	end


end
