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
    diff_t bold(b) + bold(v) times bold(b) = -grad P' - alpha bold(b) + (-1)^m nu_m nabla^(2m+2) bold(b) + bold(f)
  $
  in a periodic box where $div bold(b) = 0$. $bold(v)$ is related to $bold(b)$ as $bold(v) = (curl)^n bold(b)$. 

  For any $n$, the energy $cal(E)=angle.l 1/2 abs(bold(b))^2 angle.r$ and the helicity $cal(H)=angle.l bold(b) dot.c bold(v) angle.r$ are conserved for $nu_m = 0$ and $alpha = 0$.

  1. For a given $n$, what is the sign of $cal(H)$?
  2. Predict the direction cascade of $cal(E)$ and $cal(H)$ when $cal(H)>0$.
  3. Assuming self-similarity predict the energy spectrum for every $n$.
]
#solution[

  *NOTE*: In this exercise I changed the values concerning $m$ in the equation, in order to be consistent with the previous TD (I added the $(-1)^m$ term and replaced $nabla^(2m)$ by $nabla^(2m+2)$), so the results should change accordingly.

  1. We assume that $alpha = 0$ and $nu_m = 0$. In this case, the helicity is constant in time. Thus, it has constant sign. Assume first that $n$ is even, that is $n=2 ell$ for some $ell$. Then:
    $
      cal(H) = angle.l bold(b) dot.c bold(v) angle.r = lr(angle.l bold(b) dot.c (curl)^(2 ell) bold(b) angle.r) = lr(angle.l ((curl)^(ell) bold(b)) dot.c ((curl)^(ell) bold(b)) angle.r) = lr(angle.l |(curl)^(ell) bold(b)|^2 angle.r) >= 0
    $
    Now assume $n=2ell+1$. Then, denoting $bold(r) = (curl)^(ell) bold(b)$, we have:
    $
      cal(H) = angle.l bold(b) dot.c bold(v) angle.r = lr(angle.l bold(b) dot.c (curl)^(2 ell+1) bold(b) angle.r) = lr(angle.l ((curl)^(ell) bold(b)) dot.c ((curl)^(ell+1) bold(b)) angle.r) = lr(angle.l bold(r) dot.c (curl bold(r)) angle.r) 
    $
    and we cannot say anything about the sign of $cal(H)$.
  2. From a previous TD we have that:
    $
      diff_t cal(E) &= -alpha angle.l bold(b) dot.c bold(b) angle.r - nu_m angle.l nabla^(m+1) bold(b) dot.c nabla^(m+1) bold(b) angle.r + angle.l bold(f) dot.c bold(b) angle.r\
      & = -alpha angle.l abs(bold(b))^2 angle.r - nu_m angle.l abs(nabla^(m+1) bold(b))^2 angle.r + angle.l bold(f) dot.c bold(b) angle.r \
      & =: - epsilon_alpha - epsilon_nu_m + cal(I)_cal(E)
    $ 
    Moreover, we have that:
    $
      diff_t cal(H) &= -alpha angle.l bold(b) dot.c bold(v) angle.r - nu_m angle.l nabla^(m+1) bold(v) dot.c nabla^(m+1) bold(b) angle.r + angle.l bold(f) dot.c bold(v) angle.r\
      & =: - eta_alpha - eta_nu_m + cal(I)_cal(H)
    $
    Let $Pi_cal(E)(k)$ be the flux of energy when considering the operator $cal(P)_k^<$ and $Pi_cal(H)(k)$ the analogous flux of helicity. Now, assume that both $cal(E)$ and $cal(H)$ cascade forward as $nu_m -> 0$. Then, in the inertial regime we would have:
    $
      Pi_cal(E)(k) = epsilon_nu_m &= nu_m sum_(q=0)^oo q^(2m+2) b_q^2 tilde.eq nu_m sum_(q=k)^oo q^(2m+2) b_q^2 = nu_m k^(-n) sum_(q=k)^oo q^(2m+2)k^n b_q^2\
      &<= nu_m k^(-n) sum_(q=k)^oo q^(2m+2)q^n b_q^2 = nu_m k^(-n) sum_(q=k)^oo q^(2m+2)v_q b_q = k^(-n) eta_nu_m
    $
    Thus, making $nu_m -> 0$ and then $k -> oo$, since $eta_nu_m$ is finite, we have that $epsilon_nu_m -> 0$, which is not possible. 

    Now assume we have two inverse cascades for $cal(E)$ and $cal(H)$ with $epsilon_alpha$ and $eta_alpha$ finite as $alpha -> 0$. Then, in the inertial regime we would have:
    $
      abs(Pi_cal(H)(k)) = abs(- eta_alpha) = alpha sum_(q=0)^oo b_q v_q = alpha sum_(q=0)^oo q^n b_q^2 tilde.eq alpha sum_(q=0)^k q^n b_q^2 <= alpha k^n sum_(q=0)^k b_q^2 = alpha k^n epsilon_alpha
    $
    Thus, making $alpha -> 0$ and then $k -> 0$, since $epsilon_alpha$ is finite, we have that $Pi_cal(H)(k) -> 0$, which is not possible.

    Assuming forward cascade for $cal(E)$ and inverse cascade for $cal(H)$, we would have (doing the same calculations as before):
    $
      epsilon_nu_m <= k^(-n) eta_nu_m quad quad eta_alpha <= k^n epsilon_alpha
    $
    which is still a contradiction. But assuming inverse cascade for $cal(E)$ and forward cascade for $cal(H)$, we would have $epsilon_alpha$ finite as $k->0$ and $eta_alpha->0$ as $alpha->0$, which is possible because we have instead $eta_nu_m$ finite as $nu_m -> 0$ and $epsilon_nu_m -> 0$ as $k -> oo$.
  3. First recall that $b_ell tilde ell^n u_ell$. In the inertia regime for the helicity we have (looking at the nonlinear term):
    $
      Pi_cal(H)(k) tilde v_ell^2 b_ell tilde b_ell^3/ell^(2n) tilde eta_nu_m ==> b_ell tilde eta_(nu_m)^(1/3) ell^((2n)/3)
    $
    Thus, in this range we have $
    E(k) tilde b_ell^2/k tilde  eta_(nu_m)^(2/3) ell^((4n)/3)/k tilde eta_(nu_m)^(2/3) k^(-(4n)/3-1)
    $
    The scale at which we dissipate energy is given by:
    $
      eta_nu_m tilde nu_m v_(ell_nu)/ell_nu^(m+1) b_(ell_nu)/ell_nu^(m+1) tilde nu_m b_(ell_nu)^2/ell_nu^(2m+2 + n) tilde nu_m eta_(nu_m)^(2/3) ell_nu^((4n)/3)/ell_nu^(2m+2 + n) tilde nu_m eta_(nu_m)^(2/3) (ell_nu)^((4n)/3 - 2m - 2 - n)
    $
    Thus:
    $
      k_nu^(2m+2 - n/3) tilde eta_(nu_m)^(1/3)/nu_m ==> k_nu tilde eta_(nu_m)^(1/(6m+6 - n))nu_m^(-1/(2m+2 - n/3))
    $
    Now, in the inertial range for the energy we have:
    $
      Pi_cal(E)(k) tilde b_ell^2 v_ell tilde b_ell^3/ell^(n) tilde epsilon_alpha ==> b_ell tilde epsilon_(alpha)^(1/3) ell^(n/3)
    $
    Thus, in this range we have:
    $
      E(k) tilde b_ell^2/k tilde epsilon_alpha^(2/3) ell^(2n/3)/k tilde epsilon_alpha^(2/3) k^(-(2n)/3-1)
    $
    The scale at which we dissipate energy with drag is given by:
    $
      epsilon_alpha tilde alpha b_(ell_alpha)^2 tilde alpha epsilon_(alpha)^(2/3) ell_alpha^((2n)/3) tilde alpha epsilon_(alpha)^(2/3) k_alpha^(-(2n)/3) ==> k_alpha tilde alpha^(3/(2n)) epsilon_(alpha)^(-1/(2n))
    $
]