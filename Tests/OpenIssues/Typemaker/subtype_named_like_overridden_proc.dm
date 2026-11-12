// BYOND bug 2992612: A subtype that overrides a proc is not disambiguated from a subtype named the same
// https://www.byond.com/forum/post/2992612
// Affected: BYOND 516.1688 (also reported on 516.1667). Status: Deferred by Lummox JR.
// When /obj/base/subtype overrides open(), the compiler does not keep the subtype
// /obj/base/subtype/open apart from the proc override, so the subtype's var overrides are lost.
/obj/base
	name = "base"
	var/open = 0

/obj/base/proc/open()
	open = 1

/obj/base/subtype
	name = "subtyped"

/obj/base/subtype/open()
	open = 1

/obj/base/subtype/open
	name = "subtyped that starts open"
	open = 1

/proc/RunTest()
	var/obj/base/subtype/open/O = new
	ASSERT(O.type == /obj/base/subtype/open)
	ASSERT(O.name == "subtyped that starts open")
	ASSERT(O.open == 1)
