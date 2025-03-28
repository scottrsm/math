# math
## Mathematical Educational Papers, new Results, and Conjectures

**NOTE:** Some of the papers are written in ${\LaTeX}$ and others are written in ${\TeX}$.

The TeX papers have an "input macro" statement at the beginning of their files.
You can identify the TeX files as opposed to the ${\LaTeX}$ files by (in Linux)
moving to the 'tex' directory and issuing the command: grep -l 'input macro'  *.tex .

In any event the corresponding PDF's are in the directory **pdf/**.

### Math Education
- The Essentials of Calculus (Discrete and Continuous): **pdf**/essential_calculus.pdf.
    This is a small book which tries to motivate differential and integral Calculus through
    motivating problems.
    - Provides a view connecting the continuous Calculus with the Discrete Calculus.
    - In addition, it connects differential equations with difference equations.
    - Background material and tangential topics have been placed in appendices to keep
      the focus on the bigger picture.
    - **NOTE:** The TeX document for this PDF has not been provided.
- What is a Derivative: **tex**/what_is_a_derivative.tex.
    - This is such an important idea, but viewing it in the right way can bring
       fantastic generalizations.
- Why is Matrix Multiplication the way it is: **tex**/why_matrix_mult.tex.
    - We motivate this by solving the natural generalization of the scalar problem: ${a * x = b}$.
- What is the Determinant: **tex**/what_is_a_determinant.tex.
    - This is almost always introduced by the formula rather than what it means.
- Where does the "dot-product" come from: **tex**/inner_prod_from_projection.tex.
    - We give an alternative derivation of the dot product and how its generalization
      can be seen as a kind of software factorization.
- Why do we need Lebesgue integration: **tex**/why_lebesgue_integration.tex.
    - We motivate the Lebesgue Integrals by way of looking for better convergence theorems for Riemann Integrals.
    - Along the way we make an analogy with a "real world" system for measuring the surface area of irregular surfaces.
- Examination of Measure Theoretic Conditional Expectation in a discrete setting: **tex**/conditional_expectation_simple.tex.
    - Gain a better understanding of Measure Theory via a simple discrete setting.
    - Develop an intuition of Conditional Expectation in a measure theoretic setting.
    - Examine concrete examples of *non-measurable* functions.
    - Examine Conditional Expectation in a *singular* setting.
- Defining Fractal Dimension. 
    - Starts by producing a formula for the volume of an n dimensional sphere.
    - The resulting formula involves the *gamma* function with which one can extend a volume formula  
      for a sphere to non-integral dimensions.
    - Provides an intuitive sense with examples of the definition of *Fractal Dimension*: **tex**/fractal_dim.tex.
- A Balance Law approach to the derivation of the Heat and Fokker-Planck equations: **tex**/heat_balance.tex.
    - Often partial differential equations can be derived from simple *balance laws*.
- A derivation of the Exponential Moving Average and its associated moving Standard Deviation: **tex**/exponential_moving_average.tex.
    - *Un-biased* estimates of the *moments* of *weighted averages* is also given.
- A derivation of *diversification constraints*, useful in certain optimization problems.

### New Mathematical Results
- A formula to Compute Probability Distributions for Singular Transformations: **tex**/prob_singular_trans.tex.
    - There is a standard formula when computing the probability distribution for
      non-singular transformations. However, when it comes to singular transformations of the form: ${f: R^n \rightarrow R^m}$
      with ${m < n}$ there are only *ad hoc* procedures. In this paper we provide a systematic way to compute
      the probability distributions for such singular transformations taking into account the *foldings* of such mappings 
      from higher to lower dimensional spaces.
- Re-Examination of a Linear Unbiased Estimation Problem with a collection of related *norms*: **tex**/prob_linear_unbias_est.tex.
    - Regardless of the norms in this collection we get the same unbiased estimate.
    - This collective invariant implies that the estimator occurs when using the *limiting norm*.
      This provides insights with respect to the original unbiased problem.
- Pythagorean Triples
    - Alternative Proof of an elementary Property of Primitive Pythagorean Triples: **tex**/prop_pythag_triple.tex.
    - Conjectures regarding Primitive Pythagorean Triples: **tex**/conj_pythag_triple.tex.
    - Julia code supporting the Pythagorean triples conjecture via a Jupyter notebook: **src**/Pythag.ipynb.

### Podcast
- There is a **podcast** directory that discusses each of the papers in the directory **pdf**/.
- The format is mp3.
- There is also an RSS feed for the podcast at: https://media.rss.com/motivating-mathematical-concepts-through-problems/feed.xml

#### Version 1.5.23

