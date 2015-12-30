note

        description:

                "Provide supported TinyCC output type enumeration"

        copyright: "Copyright (c) 2015, Guillaume CHAUVET and others"
        license: "Eiffel Forum License 2"

frozen expanded class WR_TCC_OUTPUT

create
	default_create,
	make

feature
	-- Access

	memory: NATURAL = 0
    program: NATURAL = 1
    shared: NATURAL = 2
    static: NATURAL = 3

    item: NATURAL

feature {NONE}

	make (selected: NATURAL)
		do
			item := selected
		end

	members: SET [NATURAL]
		once
			Result := create {ARRAYED_SET[NATURAL]}.make (4)
			Result.fill(<<memory, program, shared, static>>)
	end

invariant

	item_is_valid: members.has (item)

end

