// BYOND bug 2992793: Equivalence operator overloads (~=, ~!) have incoherent behaviour
// https://www.byond.com/forum/post/2992793
// Affected: BYOND 516 (reproduced on 516.1688). Open, no response from Lummox JR yet.
// operator~= and operator~! overloads have their return values ignored (~= gives 0, ~! gives 1),
// and on a type that defines both, ~= calls operator~! and ~! calls operator~=.
var/global/equiv_called

/datum/equiv_only
	var/ret
	proc/operator~=(B)
		global.equiv_called += "~="
		return ret

/datum/inequiv_only
	var/ret
	proc/operator~!(B)
		global.equiv_called += "~!"
		return ret

/datum/equiv_both
	var/eq_ret
	var/neq_ret
	proc/operator~=(B)
		global.equiv_called += "~="
		return eq_ret
	proc/operator~!(B)
		global.equiv_called += "~!"
		return neq_ret

/proc/RunTest()
	var/datum/equiv_only/E = new
	var/datum/inequiv_only/N = new
	var/datum/equiv_both/EN = new

	for(var/v in list(TRUE, FALSE))
		E.ret = v
		global.equiv_called = ""
		ASSERT((E ~= 5) == v)
		ASSERT(global.equiv_called == "~=")
		// with only operator~= defined, A ~! B is !(A ~= B)
		global.equiv_called = ""
		ASSERT((E ~! 5) == !v)
		ASSERT(global.equiv_called == "~=")

		N.ret = v
		global.equiv_called = ""
		ASSERT((N ~! 5) == v)
		ASSERT(global.equiv_called == "~!")
		// with only operator~! defined, A ~= B is !(A ~! B)
		global.equiv_called = ""
		ASSERT((N ~= 5) == !v)
		ASSERT(global.equiv_called == "~!")

		EN.eq_ret = v
		EN.neq_ret = !v
		global.equiv_called = ""
		ASSERT((EN ~= 5) == v)
		ASSERT(global.equiv_called == "~=")
		global.equiv_called = ""
		ASSERT((EN ~! 5) == !v)
		ASSERT(global.equiv_called == "~!")
