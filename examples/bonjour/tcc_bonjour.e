class TCC_BONJOUR

create
	make

feature {NONE}
	-- initialization

	make
		local
			l_tcc: WR_TCC_FACADE
		do
		create l_tcc.make
		-- Library path on a X64 Linux :
		l_tcc.set_lib_path ("/usr/lib/x86_64-linux-gnu")
		l_tcc.set_output_type (l_tcc.tcc_output_memory)
		l_tcc.compile_string ("int main(int argc, char **argv)  { printf(%"Bonjour !\n%"); return 0; }")
		l_tcc.run(<<>>)
	end

end
