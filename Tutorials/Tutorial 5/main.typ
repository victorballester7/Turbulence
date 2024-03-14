#import "../math_commands.typ": *
#import "@preview/ctheorems:1.1.0": *
#import "@preview/physica:0.9.2": *
#show: thmrules

// set page dinA4
#set page(paper: "a4", margin: auto)
#set heading(numbering: "1.1.")

#let exercice = thmbox(
  "exercise", 
  "Exercise", 
  inset: 0em,
  base: none,
).with(numbering: "1")

#let solution = thmplain(
  "solution",
  "Solution",
  base: "exercise",
  inset: 0em,
).with(numbering: none)

#show list: it => pad(left: 2.5em, {
    set list(marker: style(styles => place(dx: -measure([•], styles).width, [•])))
    it
  })

#align(center, text(25pt)[
  *Tutorial 5*
])
#align(center, text(15pt)[
  Víctor Ballester Ribó\ \
  Turbulence\ 
  M2 - Applied and Theoretical Mathematics\ 
  Université Paris-Dauphine\ 
  March 2024\ 
])

#exercice[
  Consider the equation
  $
    diff_t bold(b) + bold(v) times bold(b) = -grad P' - alpha bold(b) + nu_m nabla^(2m) bold(b)
  $
  in a periodic box where $div bold(b) = 0$. $bold(v)$ is related to $bold(b)$ as $bold(v) = (curl)^n bold(b)$. 

  For any $n$, the energy $cal(E)=angle.l 1/2 abs(bold(b))^2 angle.r$ and the helicity $cal(H)=angle.l bold(b) dot.c bold(v) angle.r$ are conserved for $nu_m = 0$ and $alpha = 0$.

  1. For a given $n$, what is the sign of $cal(H)$?
  2. Predict the direction cascade of $cal(E)$ and $cal(H)$ when $cal(H)>0$.
  3. Assuming self-similarity predict the energy spectrum for every $n$.
]
#solution[
  1. We assume that $alpha = 0$ and $nu_m = 0$. In this case, the helicity is constant in time. Thus, it has constant sign. Assume first that $n$ is even, that is $n=2 ell$ for some $ell$. Then:
    $
      cal(H) = angle.l bold(b) dot.c bold(v) angle.r = lr(angle.l bold(b) dot.c (curl)^(2 ell) bold(b) angle.r) = lr(angle.l ((curl)^(ell) bold(b)) dot.c ((curl)^(ell) bold(b)) angle.r) = lr(angle.l |(curl)^(ell) bold(b)|^2 angle.r) >= 0
    $
    Now assume $n=2ell+1$. Then:
  // $
  //   cal(H) = angle.l bold(b) dot.c bold(v) angle.r = lr(angle.l bold(b) dot.c (curl)^(2 ell+1) bold(b) angle.r) = lr(angle.l ((curl)^(ell) bold(b)) dot.c ((curl)^(ell) bold(b)) angle.r) = lr(angle.l |(curl)^(ell) bold(b)|^2 angle.r) >= 0
  // $

  2.
  3.
]