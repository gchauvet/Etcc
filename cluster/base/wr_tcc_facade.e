note

	description:

		"Provide a facade interface to TinyCC library"

	copyright: "Copyright (c) 2015, Guillaume CHAUVET and others"
	license: "Eiffel Forum License 2"

class WR_TCC_FACADE

inherit
	MEMORY
		redefine
			dispose
	end

create
	make


feature
	-- Context Implementation

	enable_debug
		do
			tcc_enable_debug (context)
	end

	set_warning (warning_name: STRING; value: INTEGER)
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
			l_warning: ANY
		do
			l_warning := warning_name.to_c
			l_code := tcc_set_warning (context, $l_warning, value)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

feature
	-- Preprocessor implementation

	add_include_path (pathname: STRING)
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
			l_value: ANY
		do
			l_value := pathname.to_c
			l_code := tcc_add_include_path (context, $l_value)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

	add_include_sysinclude_path (pathname: STRING)
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
			l_value: ANY
		do
			l_value := pathname.to_c
			l_code := tcc_add_include_sysinclude_path (context, $l_value)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

	define_symbol (symbol: STRING; value: STRING)
		local
			l_symbol: ANY
			l_value: ANY
		do
			l_symbol := symbol.to_c
			l_value := value.to_c
			tcc_define_symbol (context, $l_symbol, $l_value)
	end

	undefine_symbol (symbol: STRING)
	local
		l_symbol: ANY
		do
			l_symbol := symbol.to_c
			tcc_undefine_symbol (context, $l_symbol)
	end

feature
	-- Compiling Implementation

	add_file (filename: STRING)
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
			l_value: ANY
		do
			l_value := filename.to_c
			l_code := tcc_add_file (context, $l_value)
			 if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

	compile_string (content: STRING)
		require
			a_not_empty_content: not content.is_empty
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
			l_value: ANY
		do
			l_value := content.to_c
			l_code := tcc_compile_string (context, $l_value)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

feature
	--  Linking Implementation

	add_library (pathname: STRING)
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
			l_value: ANY
		do
			l_value := pathname.to_c
			l_code := tcc_add_library (context, $l_value)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

	add_library_path (libraryname: STRING)
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
			l_value: ANY
		do
			l_value := libraryname.to_c
			l_code := tcc_add_library_path (context, $l_value)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

	set_output_file (filename: STRING)
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
			l_value: ANY
		do
			l_value := filename.to_c
			l_code := tcc_output_file (context, $l_value)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

	set_output_type (output_type: WR_TCC_OUTPUT)
		require
			output_type_not_void: output_type /= Void
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
		do
			l_code := tcc_set_output_type (context, output_type.item)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

	run (args: ARRAY[STRING])
		require
			args_not_void: args /= Void
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
			l_values: ANY
		do
			l_values := args.to_c
			l_code := tcc_run (context, args.count, $l_values)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

	set_lib_path(path: STRING)
		local
                        l_value: ANY
                do
                        l_value := path.to_c
                        tcc_set_lib_path (context, $l_value)
        end

feature {NONE}

	make
		do
			context := tcc_new
	end

	dispose
		do
			tcc_delete (context)
	end

feature {NONE}
	-- Context bindings

	context: POINTER

	tcc_new : POINTER
		external
			"C signature () : TCCState * use <libtcc.h>"
		ensure
			return_a_pointer: Result /= Void
	end

	tcc_delete (a_context: POINTER)
		external
			"C signature (TCCState *) use <libtcc.h>"
	end

	tcc_enable_debug (a_context: POINTER)
		external
			"C signature (TCCState *) use <libtcc.h>"
	end

	tcc_set_warning(a_context: POINTER; warning_name: POINTER; value: INTEGER) : INTEGER
		require
			not_void_warning_name_pointer: warning_name /= Void
			not_void_value_pointer: value /= Void
		external
			"C signature (TCCState *, const char *, const char *) : EIF_INTEGER use <libtcc.h>"
	end

feature {NONE}
	-- Preprocessor bindings

	tcc_add_include_path (a_context: POINTER; pathname: POINTER) : INTEGER
		require
			not_void_pathname: pathname /= Void
		external
			"C signature (TCCState *, const char *) : EIF_INTEGER use <libtcc.h>"
	end

	tcc_add_include_sysinclude_path (a_context: POINTER; pathname: POINTER) : INTEGER
		require
			not_void_pathname: pathname /= Void
		external
			"C signature (TCCState *, const char *) : EIF_INTEGER use <libtcc.h>"
	end

	tcc_define_symbol (a_context: POINTER; symbol: POINTER; value: POINTER)
		require
			a_valid_symbol: symbol /= Void
			a_valid_value: value /= Void
		external
			"C signature (TCCState *, const char *, const char *) use <libtcc.h>"
	end

	tcc_undefine_symbol (a_context: POINTER; symbol: POINTER)
		require
			a_valid_symbol: symbol /= Void
		external
			"C signature (TCCState *, const char *) use <libtcc.h>"
	end

feature {NONE}
	-- Compiling bindings

	tcc_add_file (a_context: POINTER; filename: POINTER) : INTEGER
		require
			not_void_filename: filename /= Void
		external
			"C signature (TCCState *, const char *) : EIF_INTEGER use <libtcc.h>"
	end

	tcc_compile_string (a_context: POINTER; content: POINTER) : INTEGER
		require
			a_valid_content: content /= Void
		external
			"C signature (TCCState *, const char *) : EIF_INTEGER use <libtcc.h>"
	end

feature {NONE}
	-- Linking bindings

	tcc_set_output_type (a_context: POINTER; output_type: NATURAL) : INTEGER
		require
			a_output_type_valid: output_type >= 0
		external
			"C signature (TCCState *, int) : EIF_INTEGER use <libtcc.h>"
	end

	tcc_add_library_path(a_context: POINTER; pathname: POINTER) : INTEGER
		require
			not_void_pathname: pathname /= Void
		external
			"C signature (TCCState *, const char *) : EIF_INTEGER use <libtcc.h>"
	end

	tcc_add_library(a_context: POINTER; libraryname: POINTER) : INTEGER
		require
			not_void_libraryname: libraryname /= Void
		external
			"C signature (TCCState *, const char *) : EIF_INTEGER use <libtcc.h>"
	end

	tcc_output_file(a_context: POINTER; filename: POINTER) : INTEGER
		require
			not_void_filename: filename /= Void
		external
			"C signature (TCCState *, const char *) : EIF_INTEGER use <libtcc.h>"
	end

	tcc_set_lib_path(a_context: POINTER; path: POINTER)
		require
			not_void_path: path /= Void
		external
			"C signature (TCCState *, const char *) use <libtcc.h>"
	end

	tcc_run(a_context: POINTER; argc: INTEGER; argv: POINTER) : INTEGER
		require
			positive_argc: argc >= 0
			not_void_argv: argv /= Void
		external
			"C signature (TCCState *, int, char **) : EIF_INTEGER use <libtcc.h>"
	end

invariant
	not_void_context: context /= Void

end
