#import "../math_commands.typ": *
#import "@preview/ctheorems:1.1.0": *
#import "@preview/physica:0.9.2": *
#show: thmrules

// set page dinA4
#set page(paper: "a4", margin: auto)
#set heading(numbering: "1.1.")

// ----------- MATH -----------
#show math.integral: math.limits.with(inline: false)

#let exercice = thmbox("exercise", "Exercise", inset: 0em, base: none).with(numbering: "1")

#let solution = thmplain("solution", "Solution", base: "exercise", inset: 0em).with(numbering: none)

#show math.equation:it => {
  if it.has("label") {
    math.equation(block: true, breakable:true, numbering: "(1)", supplement: [Eq.], it)
  } else {
    // math.equation(block: true, breakable:true, it)
    it
  }
}

#show ref: it => {
  let el = it.element
  if el != none and el.func() == math.equation {
    link(
      el.location(),
      numbering("Eq. (1)", counter(math.equation).at(el.location()).at(0) + 1),
    )
  } else {
    it
  }
}

// ---------------------------

#show enum: it => pad(left: 2.5em, {
  set enum(numbering: n => style(styles => {
    let num = numbering("1.", n)
    place(dx: -measure(num, styles).width, num)
  }))
  it
})

#show list: it => pad(
  left: 2.5em,
  {
    set list(marker: style(styles => place(dx: -measure([•], styles).width, [•])))
    it
  },
)

#show link: this => {
  let show-type = "filled" // "box" or "filled", see below
  let label-color = rgb("#006400") // dark green
  let default-color = rgb("#00008B") // dark blue

  if show-type == "box" {
    if type(this.dest) == label {
      // Make the box bound the entire text:
      set text(bottom-edge: "bounds", top-edge: "bounds")
      box(this, stroke: label-color + 1pt)
    } else {
      set text(bottom-edge: "bounds", top-edge: "bounds")
      box(this, stroke: default-color + 1pt)
    }
  } else if show-type == "filled" {
    if type(this.dest) == label {
      text(this, fill: label-color)
    } else {
      text(this, fill: default-color)
    }
  } else {
    this
  }
}

#let subfigure(body, caption: "", numbering: "(a)") = {
  let figurecount = counter(figure) // Main figure counter
  let subfigurecount = counter("subfigure") // Counter linked to main counter with additional sublevel
  let subfigurecounterdisply = counter("subfigurecounter") // Counter with only the last level of the previous counter, to allow for nice formatting

  let number = locate(
    loc => {
      let fc = figurecount.at(loc)
      let sc = subfigurecount.at(loc)

      if fc == sc.slice(0, -1) {
        subfigurecount.update(fc + (sc.last() + 1,)) // if the first levels match the main figure count, update by 1
        subfigurecounterdisply.update((sc.last() + 1,)) // Set the display counter correctly
      } else {
        subfigurecount.update(fc + (1,)) // if the first levels _don't_ match the main figure count, set to this and start at 1
        subfigurecounterdisply.update((1,)) // Set the display counter correctly
      }
      subfigurecounterdisply.display(numbering) // display the counter with the first figure level chopped off
    },
  )

  body // put in the body
  v(-.65em) // remove some whitespace that appears (inelegant I think)
  if not caption == none {
    align(center)[#number #caption] // place the caption in below the content
  }
}

#align(center, text(25pt)[
  *Tutorial 6*
])
#align(center, text(15pt)[
  Víctor Ballester Ribó\ \
  Turbulence\ 
  M2 - Applied and Theoretical Mathematics\ 
  Université Paris-Dauphine\ 
  March 2024\ 
])

In this homework we will explore some further properties of the Khokhlov solution of Burgers equation, given by
$
  u^nu (x,t) = (x - L tanh lr(((L x)/(2 nu t)))) / (t)
$
We denote $u^0$ the solution $u^0:= lim_(nu->0) u^nu$. We also denote the spatial average of any quantity $F$ as
$
  angle.l F angle.r := 1/(2L) integral_(-L)^L F(x) dd(x)
$
#exercice[
  Define $Delta u =L/t$.
  1. Use Wheeler's theorem to find what should be the limit as $nu -> 0$ of the mean dissipation per unit time of the Khokhlov solution in terms of $Delta u$.
  2. Compute the kinetic energy $E= 1/2 angle.l u^2 angle.r$ for the solution $u^0$.
  3. Deduce from that $dv(E,t)$ as a function of $Delta u$. Given that $u^0$ is a solution of Burgers equation without viscosity, do you find the result surprising?
  4. Compute the viscous dissipation for the viscous solution, $epsilon^nu = nu|diff_x u^nu|^2$.
  5. Using the formula $integral_(-oo)^(oo) 1/cosh(x)^4 dd(x)=4/3$, find $angle.l epsilon^nu angle.r$ in the limit $nu -> 0$, $L$ and $t$ fixed. Compare with $dv(E,t)$ computed in 2. Can you comment on that and on the connection with real turbulence?
  6. Use these results to compute $eta$ in this case.
]
#solution[
  1. Recall from the previous exercies that
    $
    u^0(t,x) =lim_(nu -> 0) u^nu (t,x) = (x - L sgn(x)) / t
    $
    The mean dissipation is proportial to the mean of the square of the derivative of the solution, which scales as $L^2/t^2$. Since we are asked to compute the mean dissipation per unit time, we get an estimate of $(Delta u)^3/L$.
  2. We have:
    $
    E = 1/2 angle.l u^2 angle.r &= 1/(4L) integral_(-L)^L (x - L sgn(x))^2 / t^2 dd(x)= 1/(4L) integral_(-L)^L (x^2 - 2 L abs(x) + L^2) / t^2 dd(x) \
    &= 1/(2L t^2) integral_0^L x^2 - 2 L x + L^2 dd(x)= 1/(2L t^2) (L^3/3 - 2 L^3/2 + L^3) = 1/6 L^2 / t^2
    $ 
  3. We have
    $
    dv(E,t) = -1/3 L^2 / t^3 = -1/3 (Delta u)^3 / L
    $
    At first this may be surprising, as $u^0$ is a solution of Burgers equation without viscosity, so _in principle_ there should be no dissipation. The dissipation, though, is due to the discontinuity.
  4. We have:
    $
    dv(u^nu,x) = 1/t - L^2/(2 nu t^2 cosh^2(lr((L x)/(2 nu t))))
    $
    Thus:
    $
    epsilon^nu = nu lr((1/t - L^2/(2 nu t^2 cosh^2(lr((L x)/(2 nu t))))))^2 = nu lr((1/t^2 - L^2/(nu t^3 cosh^2(lr((L x)/(2 nu t)))) + L^4/(4 nu^2 t^4 cosh^4(lr((L x)/(2 nu t))))))
    $
  5. Assume $t>0$. At the limit $nu->0$, we have:
    $
      lim_(nu -> 0)angle.l epsilon^nu angle.r &= lim_(nu -> 0)-1/(2L) integral_(-L)^L L^2/(t^3 cosh^2(lr((L x)/(2 nu t)))) dd(x) + 1/(2L) integral_(-L)^L L^4/(4 nu t^4 cosh^4(lr((L x)/(2 nu t)))) dd(x) \
      &=lim_(nu -> 0) -(L)/(t^3) integral_0^L 1/(cosh^2(lr((L x)/(2 nu t)))) dd(x) + L^3/(4nu t^4) integral_0^L 1/(cosh^4(lr((L x)/(2 nu t)))) dd(x) \
      &=lim_(nu -> 0) -(L)/(t^3) (2 nu t)/L integral_0^(L^2/(2 nu t)) 1/(cosh^2(y)) dd(y) + L^3/(4nu t^4) (2 nu t)/L integral_0^(L^2/(2 nu t)) 1/(cosh^4(y)) dd(y) \
      &= (L^2)/(2t^3) integral_0^oo 1/(cosh^4(y)) dd(y)\
      &= (L^2)/(3t^3)
    $
    where we have used that the $integral_0^oo 1/cosh^2 dd(x)$ is convergent. We see that the shock exactly dissipates the same amount of energy as the viscous solution.
  6. From the evolution of energy we have:
    $
      diff_t E + lr(angle.l u/2 diff_x (u^2) angle.r) = -nu angle.l (diff_x u)^2 angle.r
    $
    Thus, if $epsilon$ is the dissipation rate of energy we have $epsilon tilde u^3/ ell$ and $nu u^2 / ell^2 tilde u^3 / ell$, which gives $u tilde (epsilon ell)^(1/3)$ and:
    $
      nu u^2 / ell^2 tilde u^3 / ell ==> nu tilde u ell tilde epsilon^(1/3) ell^(4/3) ==> ell tilde epsilon^(-1/4) nu^(3/4) ==> eta =epsilon^(-1/4) nu^(3/4)
    $ 
    In this limit $epsilon = (L^2)/(3t^3)$, so we have $eta = L^(-1/2)/(3^(-1/4) t^(-3/4)) nu^(3/4)$.
]

#exercice[
  We define a velocity increment as $delta u(ell) = u(x + ell) - u(x)$. We define the Holder exponent as the minimum number $h$ such that there is a threshold $ell_0$ such that whenever $ell < ell_0$, then $|delta u(ell)| < C ell^h$, where $C$ is a number. We focus on $u^0$.
  1. Compute $delta u(ell)$ for $0 < x < L$.
  2. Compute $delta u(ell)$ for $x = 0$.
  3. Deduce the two possible values for the Holder exponent.
  4. Find the probability to hit the two Holder exponents, with a segment of size $ell$. Link it with the codimension of the set which support each Holder exponent.
]
#solution[
  1. Since $ell>0$ we have:
    $
    delta u^0 (ell) = u^0 (t,x + ell) - u^0 (t,x) = (x + ell - L)/t - (x - L)/t = ell/t
    $
  2. For $x=0$, $sgn(x)=0$ and thus:
    $
    delta u^0 (ell) = u^0 (t,ell) - u^0 (t,0) = (ell - L)/t
    $
  3. Near the shock, we have $h=0$ and away from the shock we have $h=1$.
  4. 
]

#exercice[
  We define structure function of order $p$ as $S_p (ell) = angle.l|u(x + ell) - u(x)|^p angle.r$.
  1. Plot graphically $S_p (ell)$ for $ell = eta/10$ to $ell = L/5$ for $L = 1$, $t = 1$ and $nu = 1, 10^(-2), 10^(-6)$ and $p = 1/3, 2/3, 1, 2, 4, 6$.
  2. Is something special happening at $ell = eta$? If not, can you measure the scale at which something special is happening, as a function of $nu$? How does it scale with $nu$?
  3. Measure $zeta(p)$ such that $S_p (ell) tilde ell^zeta(p)$ for $nu =10^(-6)$ and plot it on a graph. Can it be fitted by a log-normal model?
  4. Use results of previous section to determine the theoretical exponents, and plot them on the graph.
]
#solution[
  1. Numerically computing the structure function for $u^nu$ we obtain the following results:
    #figure(
      grid(
        columns: 3,
        rows: 1,
        gutter: 0.5em,
        subfigure(image("Images/sp_nu=1.svg", width: 100%), caption: [$nu=1$]),
        subfigure(image("Images/sp_nu=0.01.svg", width: 100%), caption: [$nu=0.01$]),
        subfigure(image("Images/sp_nu=1e-06.svg", width: 100%), caption: [$nu=10^(-6)$]),
      ),
      caption: [Structure functions for different values of $nu$ and $p$. The dashed line represents the value $ell = eta$.]
    )
  2. We note a change on the convexity of the structure function for large values of $p$, specially $p$. At $nu = 0.01$, the inflexion point is around $ell = eta$. As $nu$ decreases, the $S_p (ell)$ becomes more of the form $ell^alpha$, with $alpha < 1$.
  3. Using polynomial fitting on the data $(log (ell), log S_p(ell))$ we get the following results:
    #figure(
      image("Images/log.svg", width: 30%),
      caption: [Fitting lines to compute the exponents $zeta(p)$ for $nu = 10^(-6)$.]
    )
    #align(
      center,
      table(
        columns: 7,
        inset: 5pt,
        align: horizon,
        [$p$], [1/3], [2/3], [1], [2], [4], [6],
        [$zeta(p)$], [0.36], [0.72], [0.98], [0.98], [0.93], [0.89],
      )
    )
  4. We can compute $S_p(ell)$ in the limit $nu -> 0$:  
    $
      S_p (ell)&=1/(2L) integral_(-L)^L |u^0(t,x + ell) - u^0(t,x)|^p dd(x)\
      &=1/(2L) lr([integral_(-L)^(-ell) |u^0(t,x + ell) - u^0(t,x)|^p dd(x) + integral_(-ell)^0 |u^0(t,x + ell) - u^0(t,x)|^p dd(x) +\
      & #h(8cm)+ integral_0^L |u^0(t,x + ell) - u^0(t,x)|^p dd(x)])\
      &=1/(2L) integral_(-L)^(-ell) lr(|ell/t|)^p dd(x) + 1/(2L) integral_(-ell)^0 lr(|(ell - 2L)/t|)^p dd(x) + 1/(2L) integral_0^L lr(|ell/t|)^p dd(x)\
      &=1/(2L) (L-ell) ell^p/t^p + 1/(2L) (2L-ell)^p/t^p ell + 1/2 ell^p/t^p\
      &=lr((1-ell/(2L))) ell^p/t^p + (ell)/(2L) (2L-ell)^p/t^p\
    $
    Assume first $p<=1$. We see that for $ell << L$, $S_p$ behaves as (we take the first term of the above equation) $C_1 + C_2 ell^p$, thus we expect $zeta(p) tilde p$. For $p>1$, we have $S_p$ behaves as (we take the second term of the above equation) $C_1 + C_2 ell$, thus we expect $zeta(p) tilde 1$. Note that more or less this matches with the numerical experiments of above, specially in the regime $p <1$. For the other ones, we observe a small curvature at the right hand side of the graph, which is due to the fact thatwe are not taking $ell$ small enough.
]