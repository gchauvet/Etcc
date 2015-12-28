note

        description:

                "Provide supported TinyCC output type enumeration"

        copyright: "Copyright (c) 2015, Guillaume CHAUVET and others"
        license: "Eiffel Forum License 2"

expanded class WR_TCC_OUTPUT

create
	make

feature {NONE}
	-- Initialization

	make(selected: NATURAL)
		require
			selected_not_void: selected /= Void
		do
			item := selected
	end

feature
	-- Access

	memory: NATURAL = 0
        program: NATURAL = 1
        shared: NATURAL = 2
        static: NATURAL = 3

	item: NATURAL


feature {NONE}
	members: ARRAY [NATURAL]
		once
			Result := <<memory, program, shared, static>>
	end

invariant
	item_is_valid: members.contains (item)

end
