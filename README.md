![alt tag](http://4.bp.blogspot.com/-Xsbd1jB28S0/VMuL2jwhUWI/AAAAAAAAEDc/kaFm7dhh6vo/s1600/work%2Bin%2Bprogress.png)

# Etcc
###Eiffel binding to TinyCC library

This is a simple binding library to the embedded TCC compiler.

![alt tag](etcc.gif)

# Requirement

Under Ubuntu :
```sh
sudo apt-get install libtcc-dev
```

# Example
A short example how to use this binding :
```eiffel
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
		l_tcc.compile_string ("int main(int argc, char **argv)  { printf(%"Bonjour !%"); }")
		l_tcc.run(<<>>)
	end

end

```
