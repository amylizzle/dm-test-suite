// BYOND bug 2992947: After `ma.appearance = X` the mutable appearance holds no reference to what it copied
// https://www.byond.com/forum/post/2992947
// Affected: BYOND 516 (also 515.1637, 515.1647 and 514.1589). Open, no response from Lummox JR yet.
// After copy.appearance = source, the copy does not hold references to the copied texts. Once the
// source is gone, its run-time icon_state text is freed and its id reused, so the copy reads as
// another object's icon_state.
// The texts are built at run time on purpose, and no literal in this file equals them: a compile-time
// copy of the same text would never be freed and would hide the bug.
/proc/RunTest()
	var/n = 1
	var/mutable_appearance/source = new
	source.icon_state = "body_[n]"
	var/mutable_appearance/copy = new
	copy.appearance = source
	source = null
	var/obj/other = new
	other.icon_state = "other_[n]"
	var/state = copy.icon_state
	ASSERT(findtext(state, "body_") == 1)
