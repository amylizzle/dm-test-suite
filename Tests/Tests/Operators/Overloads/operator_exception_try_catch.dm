// BYOND bug 2992875: try/catch blocks can't catch exceptions thrown from operator overloads
// https://www.byond.com/forum/post/2992875
// Affected: BYOND 516 (516.1689 and earlier). Resolved by Lummox JR in 516.1690:
// "Operator overloads didn't pass thrown exceptions on to the parent procs."
// An exception thrown inside an operator overload (other than operator"") should reach an
// enclosing try/catch in the caller instead of being treated as uncaught.
/datum/throwing_overload/proc/operator+(B)
	throw EXCEPTION("thrown inside operator")

/proc/RunTest()
	var/datum/throwing_overload/D = new
	var/caught = null
	var/result = "unmodified"
	try
		result = D + "something"
	catch(var/exception/e)
		caught = e.name
	ASSERT(caught == "thrown inside operator")
	ASSERT(result == "unmodified")
