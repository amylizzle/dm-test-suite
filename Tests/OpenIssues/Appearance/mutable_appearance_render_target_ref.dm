// BYOND bug 2992949: A mutable appearance holds no reference to the text of its `render_target` or `render_source`
// https://www.byond.com/forum/post/2992949
// Affected: BYOND 516 (also 515.1637, 515.1647 and 514.1589). Open, no response from Lummox JR yet.
// A /mutable_appearance does not hold a reference to a render_target or render_source text built at
// run time, so the text is freed and its id is reused by the next text that is made.
// The texts are built at run time on purpose, and no literal in this file equals them: a compile-time
// copy of the same text would never be freed and would hide the bug.
/proc/RunTest()
	var/n = 1
	var/mutable_appearance/ma = new
	ma.render_target = "*target_[n]"
	var/other = "other_[n]"
	var/target = ma.render_target
	ASSERT(findtext(target, "*target_") == 1)

	var/mutable_appearance/ma2 = new
	ma2.render_source = "source_[n]"
	var/other2 = "another_[n]"
	var/source = ma2.render_source
	ASSERT(findtext(source, "source_") == 1)
	ASSERT(other && other2)
