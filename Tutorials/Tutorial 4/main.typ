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
  *Tutorial 4*
])
#align(center, text(15pt)[
  Víctor Ballester Ribó\ \
  Turbulence\ 
  M2 - Applied and Theoretical Mathematics\ 
  Université Paris-Dauphine\ 
  February 2024\ 
])

#exercice[
  The energy flux in Fourier space through a sphere of radius $k$ is given by:
  $
    Pi_E (k) = angle.l bold(u)_k^< dot.c (bold(u) dot.c nabla bold(u)) angle.r = ii sum_(abs(bold(k))<= k) sum_(bold(p) + bold(q) = bold(k)) overline(tilde(u)_bold(k)) dot.c [(bold(p) dot.c tilde(u)_bold(q)) tilde(u)_bold(p)]
  $
  Derive the same expressions for the flux of the Helicity $Pi_H (k)$ in therms of
    - $bold(u)_k^<$, $bold(w)_k^<$, $bold(u)$ and $bold(w)$
    - $tilde(bold(u))_q$, $tilde(bold(u))_k$, ...
  as above. 
]
#solution[
  We recall that $bold(u)_k^<$ is defined as 
  $
    bold(u)_k^< = cal(P)_k^<bold(u) = sum_(abs(bold(k))<=k) tilde(u)_bold(k) expp(ii bold(k) dot.c bold(x))
  $
  We need to write an expression for $diff_t cal(H)_k$, where $cal(H)_k:=1/2 angle.l bold(w)_k^< dot.c bold(u)_k^< angle.r$. From Navier Stokes equations we know that
  $
    diff_t bold(u) = -bold(u) dot.c nabla bold(u) - nabla p + nu nabla^2 bold(u) + bold(f) \
    diff_t bold(w) = curl (bold(u) times bold(w)) + nu nabla^2 bold(w) + curl bold(f)
  $
  Applying the projection operator $cal(P)_k^<$ to the first equation we get:
  $
    diff_t bold(u)_k^< = cal(P)_k^<[-bold(u) dot.c nabla bold(u)] - nabla p_k^< + nu nabla^2 bold(u)_k^< + bold(f)_k^<
  $
  where we have used that $cal(P)_k^<$ commutes with derivatives. Here $bold(f)_k^<:= cal(P)_k^<bold(f)$. Doing the same for the second equation we get:
  $
    diff_t bold(w)_k^< = cal(P)_k^< [curl (bold(u) times bold(w))] + nu nabla^2 bold(w)_k^< + curl bold(f)_k^<
  $
  Thus:
  $
    2 diff_t cal(H)_k & = angle.l bold(w)_k^< dot.c diff_t bold(u)_k^< angle.r + angle.l diff_t bold(w)_k^< dot.c bold(u)_k^< angle.r \
    & = angle.l bold(w)_k^< dot.c [cal(P)_k^<[-bold(u) dot.c nabla bold(u)] - nabla p_k^< + nu nabla^2 bold(u)_k^< + bold(f)_k^<] angle.r +\ & #h(4cm)+ angle.l [cal(P)_k^< [curl (bold(u) times bold(w))] + nu nabla^2 bold(w)_k^< + curl bold(f)_k^<] dot.c bold(u)_k^< angle.r \
    & = -angle.l bold(w)_k^< dot.c [bold(u) dot.c nabla bold(u)] angle.r - angle.l bold(w) dot.c nabla p_k^< angle.r + nu angle.l bold(w)_k^< dot.c nabla^2 bold(u)_k^< angle.r + angle.l bold(w)_k^< dot.c bold(f)_k^< angle.r +\ & #h(4cm)+ angle.l [curl (bold(u) times bold(w))] dot.c bold(u)_k^< angle.r + nu angle.l nabla^2 bold(w)_k^< dot.c bold(u)_k^< angle.r + angle.l curl bold(f)_k^< dot.c bold(u)_k^< angle.r \
    & = -angle.l bold(w)_k^< dot.c [bold(u) dot.c nabla bold(u)] angle.r  - nu angle.l curl bold(w)_k^< dot.c curl bold(u)_k^< angle.r + angle.l bold(w)_k^< dot.c bold(f)_k^< angle.r +\ & #h(4cm)+ angle.l [curl (bold(u) times bold(w))] dot.c bold(u)_k^< angle.r - nu angle.l curl bold(w)_k^< dot.c curl bold(u)_k^< angle.r + angle.l bold(f)_k^< dot.c curl bold(u)_k^< angle.r \
    & = -angle.l bold(w)_k^< dot.c [bold(u) dot.c nabla bold(u)] angle.r + angle.l [curl (bold(u) times bold(w))] dot.c bold(u)_k^< angle.r -nu angle.l curl bold(w)_k^< dot.c bold(w)_k^< angle.r + 2 angle.l bold(w)_k^< dot.c bold(f)_k^< angle.r \
    & =: Pi_H (k) - epsilon_H^< (k) + cal(I)_H^< (k)
    $
    where:
    $
    Pi_H (k) := angle.l bold(w)_k^< dot.c [bold(u) dot.c nabla bold(u)] angle.r - angle.l [curl (bold(u) times bold(w))] dot.c bold(u)_k^< angle.r
    $

    Now we will deduce the other equivalent expression for $Pi_H (k)$ in terms of $tilde(bold(u))_q$, $tilde(bold(u))_k$, ... 

    We already know the Navier Stokes equation in Fourier space:
    $
    diff_t tilde(bold(u))_k = -ii sum_(bold(p) + bold(q) = bold(k)) lr(((bold(p) dot.c tilde(bold(u))_bold(q))tilde(bold(u))_bold(p) - bold(k) ((bold(k) dot.c tilde(bold(u))_bold(p)) (bold(p) dot.c tilde(bold(u))_bold(q))) / (|bold(k)|^2))) - nu |bold(k)|^2 tilde(bold(u))_k + tilde(bold(f))_k
    $

    We just need to find the expression for $angle.l (curl (bold(u) times bold(w))) expp(-ii bold(k) dot.c bold(x)) angle.r$, which is the Fourier transform of the nonlinear term in the vorticity equation. We have:
    $
    angle.l (curl (bold(u) times bold(w))) expp(-ii bold(k) dot.c bold(x)) angle.r &= lr(angle.l (curl [(sum_(bold(p)) tilde(bold(u))_bold(p) expp(ii bold(p) dot.c bold(x))) times (sum_(bold(q)) tilde(bold(w))_bold(q) expp(ii bold(q) dot.c bold(x)))]) expp(-ii bold(k) dot.c bold(x)) angle.r) \
    &= lr(angle.l sum_(bold(p), bold(q)) [curl [(tilde(bold(u))_bold(p) expp(ii bold(p) dot.c bold(x))) times (tilde(bold(w))_bold(q) expp(ii bold(q) dot.c bold(x)))] ]expp(-ii bold(k) dot.c bold(x)) angle.r) \
    &= lr(angle.l sum_(bold(p), bold(q)) [curl (expp(ii (bold(p) + bold(q)) dot.c bold(x)) (tilde(bold(u))_bold(p) times tilde(bold(w))_bold(q))) ]expp(-ii bold(k) dot.c bold(x)) angle.r) \
    &= ii lr(angle.l sum_(bold(p), bold(q)) expp(ii (bold(p) + bold(q) - bold(k)) dot.c bold(x)) (bold(p) + bold(q)) times (tilde(bold(u))_bold(p) times tilde(bold(w))_bold(q)) angle.r) \
    &= ii sum_(bold(p) + bold(q) = bold(k))  (bold(p) + bold(q)) times (tilde(bold(u))_bold(p) times tilde(bold(w))_bold(q))
    $
    Thus:
    $
    diff_t tilde(bold(w))_bold(k) = ii sum_(bold(p) + bold(q) = bold(k))  (bold(p) + bold(q)) times (tilde(bold(u))_bold(p) times tilde(bold(w))_bold(q)) + ...
    $

    In Fourier space, the Helicity is given by $cal(H) = 1/2 sum_bold(k) overline(tilde(bold(w))_bold(k)) dot.c tilde(bold(u))_bold(k)$ (Parseval identity). Thus:
    $
    diff_t cal(H)_k &= 1/2 sum_(bold(k)<=k) [(diff_t overline(tilde(bold(w))_bold(k))) dot.c tilde(bold(u))_bold(k) + overline(tilde(bold(w))_bold(k)) dot.c (diff_t tilde(bold(u))_bold(k))] \ 
    &= -ii/2 sum_(bold(k)<=k) sum_(bold(p) + bold(q) = bold(k)) [(bold(p) + bold(q)) times (overline(tilde(bold(u))_bold(p)) times overline(tilde(bold(w))_bold(q))) dot.c tilde(bold(u))_bold(k) +  overline(tilde(bold(w))_bold(k)) dot.c (bold(p) dot.c tilde(bold(u))_bold(q) )tilde(bold(u))_bold(p)] + ...
    $
    Thus, the other equivalent expression for $Pi_H (k)$ in terms of $tilde(bold(u))_q$, $tilde(bold(u))_k$, ... is:
    $
    Pi_H (k) = -ii/2 sum_(bold(k)<=k) sum_(bold(p) + bold(q) = bold(k)) [(bold(p) + bold(q)) times (overline(tilde(bold(u))_bold(p)) times overline(tilde(bold(w))_bold(q))) dot.c tilde(bold(u))_bold(k) +  overline(tilde(bold(w))_bold(k)) dot.c (bold(p) dot.c tilde(bold(u))_bold(q) )tilde(bold(u))_bold(p)]
    $
]