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
		l_tcc.compile_string ("int main(int argc, char **argv) { printf(%"Bonjour !%"); }")
		l_tcc.set_output_type (l_tcc.tcc_output_program)
		l_tcc.output_file ("bonjour")
	end

end
