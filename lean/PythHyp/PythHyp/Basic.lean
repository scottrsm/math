import Mathlib.NumberTheory.PythagoreanTriples
import Mathlib.NumberTheory.SumTwoSquares
import Mathlib.NumberTheory.Zsqrtd.GaussianInt
import Mathlib.NumberTheory.PrimesCongruentOne
import Mathlib.Data.Nat.PrimeFin

open Set

namespace PrimPythHyp

/-- z is a primitive Pythagorean hypotenuse. -/
def IsHyp (z : ℕ) : Prop :=
  ∃ a b : ℕ, 0 < a ∧ 0 < b ∧ Nat.gcd a b = 1 ∧ a^2 + b^2 = z^2

def H : Set ℕ := { z | IsHyp z }
def Hp : Set ℕ := { z | z ∈ H ∧ z.Prime }

/-- Hypotenuses with at least two distinct unordered primitive representations. -/
def Hd : Set ℕ :=
  { z | ∃ a₁ b₁ a₂ b₂ : ℕ,
      0 < a₁ ∧ 0 < b₁ ∧ Nat.gcd a₁ b₁ = 1 ∧ a₁^2 + b₁^2 = z^2 ∧
      0 < a₂ ∧ 0 < b₂ ∧ Nat.gcd a₂ b₂ = 1 ∧ a₂^2 + b₂^2 = z^2 ∧
      ({a₁, b₁} : Finset ℕ) ≠ {a₂, b₂} }

/-- Powers of Pythagorean primes. -/
def Hu : Set ℕ := { z | ∃ p ∈ Hp, ∃ n : ℕ, 0 < n ∧ z = p^n }

----------------------------------------------------------------------
-- Classical building blocks (axiomatized; these are real theorems)
----------------------------------------------------------------------

/-- (F) Fermat's two-squares + multiplicativity in ℤ[i]. -/
axiom mem_H_iff_factors {z : ℕ} (hz : 1 < z) :
    z ∈ H ↔ ∀ p ∈ z.primeFactors, p % 4 = 1

/-- (G-easy) If z has ≥ 2 distinct prime factors (all ≡ 1 mod 4), then z has at least
    two distinct unordered primitive representations a^2+b^2 = z^2.  This is the
    part of the Gauss count we actually use for the partition theorem. -/
axiom multiple_factors_yields_Hd {z : ℕ} (hz : z ∈ H) (hk : 2 ≤ z.primeFactors.card) :
    z ∈ Hd

/-- (G-uniq) If z = p^n for a Pythagorean prime p and n ≥ 1, then z has only one
    unordered primitive representation a^2+b^2 = z^2 (so z ∉ Hd). -/
axiom prime_power_not_in_Hd {p : ℕ} (hp : p ∈ Hp) {n : ℕ} (hn : 0 < n) :
    p^n ∉ Hd

----------------------------------------------------------------------
-- Helpers
----------------------------------------------------------------------

lemma one_lt_of_in_H {z : ℕ} (hz : z ∈ H) : 1 < z := by
  obtain ⟨a, b, ha, hb, _, hab⟩ := hz
  have h1a : 1 ≤ a^2 := Nat.one_le_iff_ne_zero.mpr (pow_ne_zero 2 ha.ne')
  have h1b : 1 ≤ b^2 := Nat.one_le_iff_ne_zero.mpr (pow_ne_zero 2 hb.ne')
  have h2 : 2 ≤ z^2 := by rw [← hab]; omega
  -- From z^2 ≥ 2 we get z ≥ 2.
  rcases Nat.lt_or_ge z 2 with hlt | hge
  · interval_cases z <;> simp_all
  · omega

----------------------------------------------------------------------
-- Theorem 3
----------------------------------------------------------------------

/-- (a) H = Hd ∪ Hu. -/
theorem H_eq_Hd_union_Hu : H = Hd ∪ Hu := by
  ext z
  refine ⟨fun hz => ?_, ?_⟩
  · -- z ∈ H. Split on z.primeFactors.card.
    have hz1 : 1 < z := one_lt_of_in_H hz
    have hz_ne : z ≠ 0 := by omega
    have hcard_pos : 1 ≤ z.primeFactors.card := by
      have : z.primeFactors.Nonempty := by
        rw [Nat.nonempty_primeFactors]; exact hz1
      exact Finset.card_pos.mpr this
    by_cases hk : z.primeFactors.card = 1
    · -- One prime factor: z = p^n for that prime p.
      right
      obtain ⟨p, hp_eq⟩ := Finset.card_eq_one.mp hk
      have hp_in : p ∈ z.primeFactors := by rw [hp_eq]; exact Finset.mem_singleton_self p
      have hp_prime : p.Prime := Nat.prime_of_mem_primeFactors hp_in
      have hp_dvd : p ∣ z := Nat.dvd_of_mem_primeFactors hp_in
      -- The exponent n = z.factorization p, with z = p^n.
      set n := z.factorization p
      have hn_pos : 0 < n := hp_prime.factorization_pos_of_dvd hz_ne hp_dvd
      have hz_eq : z = p ^ n := by
        -- z = ∏ q in z.primeFactors, q ^ z.factorization q.
        -- Since the only factor is p:
        have hprod : z.factorization.prod (· ^ ·) = z :=
          Nat.prod_factorization_pow_eq_self hz_ne
        have hsupp : z.factorization.support = {p} := by
          rw [Nat.support_factorization, hp_eq]
        rw [← hprod, Finsupp.prod, hsupp, Finset.prod_singleton]
      refine ⟨p, ⟨?_, hp_prime⟩, n, hn_pos, hz_eq⟩
      -- Need p ∈ H. Use mem_H_iff_factors with the fact that p.primeFactors = {p}.
      rw [mem_H_iff_factors hp_prime.one_lt]
      intro q hq
      rw [hp_prime.primeFactors, Finset.mem_singleton] at hq
      rw [hq]
      exact (mem_H_iff_factors hz1).mp hz p hp_in
    · -- ≥ 2 prime factors: z ∈ Hd by multiple_factors_yields_Hd.
      left
      have hk2 : 2 ≤ z.primeFactors.card := by omega
      exact multiple_factors_yields_Hd hz hk2
  · rintro (hd | hu)
    · -- Hd ⊆ H: take the first triple as witness.
      obtain ⟨a, b, _, _, ha, hb, hgcd, heq, _⟩ := hd
      exact ⟨a, b, ha, hb, hgcd, heq⟩
    · -- Hu ⊆ H: powers of Pythagorean primes are in H.
      obtain ⟨p, hpH, n, hn, rfl⟩ := hu
      have hp_prime : p.Prime := hpH.2
      have hpn_gt1 : 1 < p^n := one_lt_pow₀ hp_prime.one_lt hn.ne'
      rw [mem_H_iff_factors hpn_gt1]
      intro q hq
      have hpf : (p^n).primeFactors = {p} := Nat.primeFactors_prime_pow hn.ne' hp_prime
      rw [hpf, Finset.mem_singleton] at hq
      rw [hq]
      exact (mem_H_iff_factors hp_prime.one_lt).mp hpH.1 p hp_prime.mem_primeFactors_self

/-- (b) Hd ∩ Hu = ∅. -/
theorem Hd_inter_Hu : Hd ∩ Hu = ∅ := by
  ext z
  simp only [mem_inter_iff, mem_empty_iff_false, iff_false, not_and]
  rintro hd ⟨p, hpH, n, hn, rfl⟩
  exact prime_power_not_in_Hd hpH hn hd

/-- (c) Hd is infinite.

Strategy: from Dirichlet (`Nat.infinite_setOf_prime_modEq_one` with k = 4),
pick infinitely many primes p ≡ 1 (mod 4) with p ≠ 5. The map p ↦ 5*p sends
each such p into Hd: since 5 and p are distinct Pythagorean primes, 5*p has
two distinct prime factors. The map is injective, so the image is infinite. -/
theorem Hd_infinite : Hd.Infinite := by
  -- The set of primes ≡ 1 (mod 4), with 5 removed.
  set S : Set ℕ := {p | p.Prime ∧ p ≡ 1 [MOD 4]} \ {5}
  have h_pyth : Set.Infinite {p : ℕ | p.Prime ∧ p ≡ 1 [MOD 4]} :=
    Nat.infinite_setOf_prime_modEq_one (by norm_num)
  have hS_inf : S.Infinite := h_pyth.diff (Set.finite_singleton _)
  -- The map p ↦ 5 * p is injective and lands in Hd.
  apply Set.infinite_of_injOn_mapsTo
    (s := S) (t := Hd) (f := fun p => 5 * p)
  · -- InjOn
    intro p₁ _ p₂ _ h
    dsimp only at h
    omega
  · -- MapsTo
    intro p hpS
    obtain ⟨⟨hp_prime, hp_mod⟩, hp_ne⟩ := hpS
    have hp_ne_5 : p ≠ 5 := fun h => hp_ne (by simp [h])
    have h5_prime : Nat.Prime 5 := by decide
    have hp_pos : 0 < p := hp_prime.pos
    have hp_ne0 : p ≠ 0 := hp_pos.ne'
    have h5p_gt1 : 1 < 5 * p := by
      have : 1 < p := hp_prime.one_lt
      omega
    -- Membership in H by Fermat's characterization.
    have h5_in : (5 : ℕ) ∈ (5*p).primeFactors :=
      Nat.mem_primeFactors.mpr ⟨h5_prime, ⟨p, rfl⟩, by omega⟩
    have hp_in : p ∈ (5*p).primeFactors :=
      Nat.mem_primeFactors.mpr ⟨hp_prime, ⟨5, by ring⟩, by omega⟩
    have h5p_in_H : 5 * p ∈ H := by
      rw [mem_H_iff_factors h5p_gt1]
      rw [Nat.primeFactors_mul (by norm_num) hp_ne0,
        h5_prime.primeFactors, hp_prime.primeFactors]
      intro q hq
      rw [Finset.mem_union, Finset.mem_singleton, Finset.mem_singleton] at hq
      rcases hq with rfl | rfl
      · decide
      · exact hp_mod
    -- (5*p).primeFactors.card ≥ 2.
    have hcard : 2 ≤ (5*p).primeFactors.card := by
      have hsub : ({5, p} : Finset ℕ) ⊆ (5*p).primeFactors := by
        intro x hx
        rw [Finset.mem_insert, Finset.mem_singleton] at hx
        rcases hx with rfl | rfl <;> assumption
      have h2 : ({5, p} : Finset ℕ).card = 2 := by
        rw [Finset.card_insert_of_notMem (by simp [Ne.symm hp_ne_5]),
          Finset.card_singleton]
      calc 2 = _ := h2.symm
        _ ≤ _ := Finset.card_le_card hsub
    exact multiple_factors_yields_Hd h5p_in_H hcard
  · exact hS_inf

/-- Theorem 3 of the paper: the partition theorem. -/
theorem H_partition :
    H = Hd ∪ Hu ∧ Hd ∩ Hu = ∅ ∧ Hd.Infinite :=
  ⟨H_eq_Hd_union_Hu, Hd_inter_Hu, Hd_infinite⟩

end PrimPythHyp
