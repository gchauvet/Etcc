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
		l_tcc.compile_string ("int main(int argc, char **argv)  { printf(%"Bonjour !%"); return 0; }")
		l_tcc.run(<<>>)
	end

end
