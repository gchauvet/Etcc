![alt tag](http://4.bp.blogspot.com/-Xsbd1jB28S0/VMuL2jwhUWI/AAAAAAAAEDc/kaFm7dhh6vo/s1600/work%2Bin%2Bprogress.png)

# Etcc
###Eiffel binding to TinyCC library

This is a simple binding library to the embedded TCC compiler.

![alt tag](etcc.gif)

# Requirement

Ubuntu distribution:
```sh
sudo apt-get install libtcc-dev
git clone https://github.com/gchauvet/Etcc.git
cd Etcc
export TCC_LIB=`pwd`
```

# Installation

Ubuntu distribution:
```sh
git clone https://github.com/gchauvet/Etcc.git
cd Etcc
export TCC_LIB=`pwd`
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
		l_tcc.compile_string ("int main(int argc, char **argv)  { printf(%"Bonjour !%"); return 0; }")
		l_tcc.run(<<>>)
	end

end

```
