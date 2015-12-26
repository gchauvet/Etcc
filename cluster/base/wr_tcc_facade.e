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
		do
			l_code := tcc_set_warning (context, warning_name, value)
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
		do
			l_code := tcc_add_include_path (context, pathname)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

	add_include_sysinclude_path (pathname: STRING)
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
		do
			l_code := tcc_add_include_sysinclude_path (context, pathname)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

	define_symbol (symbol: STRING; value: STRING)
		do
			tcc_define_symbol (context, symbol, value)
	end

	undefine_symbol (symbol: STRING)
		do
			tcc_undefine_symbole (context, symbol)
	end

feature
	-- Compiling Implementation

	add_file (filename: STRING)
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
		do
			l_code := tcc_add_file (context, filename)
			 if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

	compile_string (content: STRING)
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
		do
			l_code := tcc_compile_string (context, content)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

feature
	--  Linking Implementation

	add_library_path (pathname: STRING)
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
		do
			l_code := tcc_library_path (context, pathname)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

	add_library (libraryname: STRING)
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
		do
			l_code := tcc_add_library (context, libraryname)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

	output_file (filename: STRING)
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
		do
			l_code := tcc_output_file (context, filename)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
	end

	set_output_type (output_type: INTEGER)
		local
			l_exception: WR_TCC_EXCEPTION
			l_code: INTEGER
		do
			l_code := tcc_set_output_type (context, output_type)
			if l_code < 0 then
				create l_exception.make (l_code)
				l_exception.raise
			end
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
			have_a_pointer: Result /= Void
	end

	tcc_delete (a_context: POINTER)
		require
			not_void_context_pointer: a_context /= Void
		external
			"C signature (TCCState *) use <libtcc.h>"
	end

	tcc_enable_debug (a_context: POINTER)
		require
			not_void_context_pointer: a_context /= Void
		external
			"C signature (TCCState *) use <libtcc.h>"
	end

	tcc_set_warning(a_context: POINTER; warning_name: STRING; value: INTEGER) : INTEGER
		require
			not_void_context_pointer: a_context /= Void
		external
			"C signature (TCCState *, const char *, const char *) use <libtcc.h>"
	end

feature {NONE}
	-- Preprocessor bindings

	tcc_add_include_path (a_context: POINTER; pathname: STRING) : INTEGER
		require
			not_void_context_pointer: a_context /= Void
			a_valid_pathname: file_system.is_valid_directory(pathname)
		external
			"C signature (TCCState *, const char *) use <libtcc.h>"
	end

	tcc_add_include_sysinclude_path (a_context: POINTER; pathname: STRING) : INTEGER
		require
			not_void_context_pointer: a_context /= Void
			not_void_valid_symbol: symbol /= Void
			not_empty_valid_symbol: not symbol.is_empty
			a_valid_pathname: file_system.is_valid_directory(pathname)
		external
			"C signature (TCCState *, const char *) use <libtcc.h>"
	end

	tcc_define_symbol (a_context: POINTER; symbol: STRING; value: STRING)
		require
			not_void_context_pointer: a_context /= Void
			a_valid_symbol: symbol /= Void
			a_not_empty_symbol: not symbol.is_empty
			a_valid_value: value /= Void
			a_not_empty_value: not value.is_empty
		external
			"C signature (TCCState *, const char *, const char *) use <libtcc.h>"
	end

	tcc_undefine_symbol (a_context: POINTER; symbol: STRING)
		require
			not_void_context_pointer: a_context /= Void
			a_valid_symbol: symbol /= Void
			a_not_empty_symbol: not symbol.is_empty
		external
			"C signature (TCCState *, const char *) use <libtcc.h>"
	end

feature {NONE}
	-- Compiling bindings

	tcc_add_file (a_context: POINTER; filename: STRING) : INTEGER
		require
			not_void_context_pointer: a_context /= Void
			a_valid_filename: file_system.is_valid_filename(filename)
		external
			"C signature (TCCState *, const char *) use <libtcc.h>"
	end

	tcc_compile_string (a_context: POINTER; content: STRING) : INTEGER
		require
			not_void_context_pointer: a_context /= Void
			a_valid_content: content /= Void
			a_not_empty_content: not content.is_empty
		external
			"C signature (TCCState *, const char *) use <libtcc.h>"
	end

feature
	-- Linking bindings options
	tcc_output_memory: INTEGER = 0
	tcc_output_program: INTEGER = 1
	tcc_output_shared: INTEGER = 2
	tcc_output_static: INTEGER = 3

feature {NONE}
	-- Linking bindings

	tcc_set_output_type (a_context: POINTER; output_type: INTEGER) : INTEGER
		require
			not_void_context_pointer: a_context /= Void
			a_output_type_valid: output_type >= tcc_output_memory and output_type <= tcc_output_static
		external
			"C signature (TCCState *, int) use <libtcc.h>"
	end

	tcc_add_library_path(a_context: POINTER; pathname: STRING) : INTEGER
		require
			not_void_context_pointer: a_context /= Void
			a_valid_pathname: file_system.is_valid_directory(pathname)
		external
			"C signature (TCCState *, const char *) use <libtcc.h>"
	end

	tcc_add_library(a_context: POINTER; libraryname: STRING) : INTEGER
		require
			not_void_context_pointer: a_context /= Void
			a_valid_libraryname: libraryname /= Void
			a_not_empty_libraryname: not libraryname.is_empty
		external
			"C signature (TCCState *, const char *) use <libtcc.h>"
	end

	tcc_output_file(a_context: POINTER; filename: STRING) : INTEGER
		require
			not_void_context_pointer: a_context /= Void
			a_valid_filename: file_system.is_valid_filename (filename)
		external
			"C signature (TCCState *, const char *) use <libtcc.h>"
	end

	tcc_set_lib_path(a_context: POINTER; path: STRING)
		require
			not_void_context_pointer: a_context /= Void
			a_valid_pathname: file_system.is_valid_directory(path)
		external
			"C signature (TCCState *, const char *) use <libtcc.h>"
	end

end
