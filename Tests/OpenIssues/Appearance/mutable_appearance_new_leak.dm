// BYOND bug 2992948: `new /mutable_appearance(X)` leaks a reference to X's appearance
// https://www.byond.com/forum/post/2992948
// Affected: BYOND 516 (also 515.1637, 515.1647 and 514.1589). Open, no response from Lummox JR yet.
// Creating a /mutable_appearance from an atom adds a reference to the atom's appearance that is
// never released, even after the mutable appearance is gone.
/proc/RunTest()
	var/obj/O = new
	O.icon_state = "state"
	var/look = O.appearance
	var/before = refcount(look)
	new /mutable_appearance(O)
	ASSERT(refcount(look) == before)
