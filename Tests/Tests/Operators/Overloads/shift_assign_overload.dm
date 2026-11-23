// BYOND bug 2992876: operator<<= and operator>>= ignore overloaded return value
// https://www.byond.com/forum/post/2992876
// Affected: BYOND 516 (516.1689 and earlier). Resolved by Lummox JR in 516.1690:
// "Shift-and-assign operator overloads didn't work correctly, returning the original object
// instead of the result of the overload."
// With only operator<< and operator>> defined, S <<= x and S >>= x should assign the value those
// overloads return to S.
/datum/shifty
	var/offset = 0

/datum/shifty/New(offset = 0)
	src.offset = offset

/datum/shifty/proc/operator<<(B)
	return new /datum/shifty(offset - B)

/datum/shifty/proc/operator>>(B)
	return new /datum/shifty(offset + B)

/proc/RunTest()
	var/datum/shifty/S = new
	var/datum/shifty/original = S
	S <<= 1
	ASSERT(S != original)
	ASSERT(S.offset == -1)
	S >>= 2
	ASSERT(S.offset == 1)
