# PythHyp

A Lean 4 / Mathlib formalization related to the Pythagorean-hypotenuse
conjectures explored in `tex/conj_pythag_triple.tex` and
`tex/prop_pythag_triple.tex` (see the top-level `pdf/conj_pythag_triple.pdf`
and `pdf/prop_pythag_triple.pdf`).

## What it formalizes

`PythHyp/Basic.lean` works in the namespace `PrimPythHyp` with the set of
primitive Pythagorean hypotenuses

```
H  := { z : ℕ | ∃ a b, 0 < a ∧ 0 < b ∧ gcd a b = 1 ∧ a^2 + b^2 = z^2 }
```

and two derived subsets:

- `Hd` -- hypotenuses with at least two distinct unordered primitive
  representations `a^2 + b^2 = z^2`.
- `Hu` -- powers of "Pythagorean primes" (primes that are themselves
  hypotenuses of a primitive triple).

Building on classical facts (Fermat's two-squares theorem and its
multiplicativity in `ℤ[i]`, taken here as axioms), the file proves the
partition theorem (`H_partition`):

- `H = Hd ∪ Hu`
- `Hd ∩ Hu = ∅`
- `Hd` is infinite

i.e. every primitive Pythagorean hypotenuse either has multiple primitive
representations or is a power of a single Pythagorean prime, these two
cases are mutually exclusive, and the "multiple representations" case
occurs infinitely often.

## Building

This is a standard Lake/Mathlib project.

- Toolchain: `leanprover/lean4:v4.29.1` (see `lean-toolchain`).
- Dependency: `mathlib` (rev `v4.29.1`, see `lakefile.toml`).

To build:

```sh
lake build
```

The first build will fetch and build Mathlib via `lake exe cache get`
(recommended) or from source, which can take a while.
