// BYOND bug 2992984: `a++` and `++a` as statements call `operator++` without its argument and discard the result
// https://www.byond.com/forum/post/2992984
// Affected: BYOND 516 (also 515.1637 and 515.1647). Open; Lummox JR confirmed the discarded result is a bug.
// When a++ or ++a is used as a statement of its own, the value returned by operator++ should become
// the new value of a, as it does when the operator is used in an expression.
// (Calling operator++ with no argument in the statement case is intended, so it is not checked here.)
/datum/incrementer
	var/value = 0

/datum/incrementer/proc/operator++()
	var/datum/incrementer/R = new
	R.value = value + 1
	return R

/proc/RunTest()
	var/datum/incrementer/a = new
	var/datum/incrementer/old = a
	a++
	ASSERT(a != old)
	ASSERT(a.value == 1)

	old = a
	++a
	ASSERT(a != old)
	ASSERT(a.value == 2)
