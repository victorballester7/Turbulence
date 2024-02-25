#import "@preview/ctheorems:1.1.0": *
#import "@preview/physica:0.9.2": *
#import "../math_commands.typ": *
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
    math.equation(block: true, numbering: "(1)", supplement: [Eq.], it)
  } else {
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
  *Tutorial 3*
])
#align(center, text(15pt)[
  Víctor Ballester Ribó\ \
  Turbulence\
  M2 - Applied and Theoretical Mathematics\
  Université Paris-Dauphine\
  February 2024\
])

#exercice[
  In this homework, we will explore some properties of Burgers equation.
  $
    diff_t V_i + V_j diff_j V_i = nu laplace V_i
  $ <eq:11>
  $
    V_i = - diff_i Psi
  $ <eq:12>
  1. Use @eq:12 to find the equation for $Psi$.
  2. 1D case: Check that the "Khokhlov" velocity field $u^nu (x,t)=lr(x-L tanh((L x)/(2 nu t)))/t$ is
    a solution of @eq:11. Draw it at several times for $L=1$, and $nu = 1, 10^(-2), 10^(-6)$.
  3. Find the limit of the Khokhlov solution as $nu -> 0$. This solution represents a
    shock.
]<ex:1>
#solution[
  1. Inserting @eq:12 into @eq:11, we get:
    $
      -diff_t diff_i Psi + diff_j Psi diff_j diff_i Psi &= -nu diff_j^2 diff_i Psi\
      diff_i lr((diff_t Psi - 1/2 (diff_j Psi)^2))      &= diff_i lr((nu laplace Psi)) \
    $
    $
      diff_t Psi - 1/2 (diff_j Psi)^2 &= nu laplace Psi + f(t)
    $ <eq:13>\
    Note that the constant $f(t)$ does not depend on any spatial variable $x_i$,
    because for each $i$, the equation is the same for $Psi$. Thus, it can only
    depend on time.

  2. We need to check that:
    $
      diff_t u^nu + u^nu diff_x u^nu = nu diff_(x x) u^nu
    $
    We have that:
    $
      diff_t u^nu         &= - (x-L tanh((L x)/(2 nu t)))/t^2 + (L^2 x)/(2 nu t^2) (sech((L x)/(2 nu t)))^2 \
      diff_x u^nu         &= 1/t - L^2/(2 nu t^2) (sech((L x)/(2 nu t)))^2 \
      u^nu diff_x u^nu    &= x/t^2 - (L^2 x)/(2 nu t^3) (sech((L x)/(2 nu t)))^2 - L/t^2 tanh((L x)/(2 nu t)) + (L^3 x)/(2 nu t^3) (sech((L x)/(2 nu t)))^2 tanh((L x)/(2 nu t)) \
      -nu diff_(x x) u^nu &= - L^3/(2 nu t^3) (sech((L x)/(2 nu t)))^3 sinh((L x)/(2 nu t))
    $
    Adding all the terms (except the second one), we get 0. Thus, the equation is
    satisfied. In
    #figure(
      grid(
        columns: 3,
        rows: 2,
        gutter: 0.5em,
        subfigure(image("Images/burger_t=0.01.svg", width: 100%), caption: [$t=0.01$]),
        subfigure(image("Images/burger_t=0.1.svg", width: 100%), caption: [$t=0.1$]),
        subfigure(image("Images/burger_t=0.5.svg", width: 100%), caption: [$t=0.5$]),
        subfigure(image("Images/burger_t=2.svg", width: 100%), caption: [$t=0.2$]),
        subfigure(image("Images/burger_t=10.svg", width: 100%), caption: [$t=10$]),
        subfigure(
          image("Images/burger_t=100000.svg", width: 100%),
          caption: [$t=100000$],
        ),
      ),
      caption: [Khokhlov velocity field for different values of $t$ and $nu$],
    )

  3. Fix $x in RR$ and $t > 0$. Then, since $lim_(y -> plus.minus oo) tanh(y) = plus.minus 1$,
    we have that:
    $
      u(x,t) := lim_(nu -> 0) u^nu (x,t) = lim_(nu -> 0) lr(x-L tanh((L x)/(2 nu t)))/t = lr(x-L sgn(x))/t
    $
    where we have assumed that $L > 0$. This function is not continuous at $x = 0$ for
    any $t>0$, which is the signature of a shock.
]

#exercice[
  The Hopf-Cole transformation is defined as:
  $
    V_i= - 2 nu diff_i log(Phi)
  $ <eq:21>
  1. Find the link between $Psi$ and $Phi$.
  2. Show that the equation for $Phi$ is linear (it is the heat equation).
  3. Consider the 1D case. Find the solution of the heat equation in case of periodic
    boundary conditions.
]
#solution[
  1. For each $i$, we have that $-diff_i Psi = -2 nu diff_i log(Phi)$. Thus,
    integrating with respect to $x_i$, we get $Psi = 2 nu log(Phi) + g(t)$, and
    again, the constant $g(t)$ does not depend on any spatial variable $x_i$ (by the
    same argument as in the previous exercise). We can in fact determine $g$ from
    @eq:13. Since $V_i = -diff_i(2 nu log(Phi))$, then by @ex:1 $2 nu log(Phi)$ satisfies
    also @eq:13 and thus by the linearity of the derivatives we get that $g'(t) = f(t)$.

  2. From @eq:13 we get:
    $
      diff_t Psi - 1/2 (diff_j Psi)^2                              &= nu laplace Psi + f(t) \
      diff_t (2 nu log(Phi) + g(t)) - 1/2 (2 nu diff_j log(Phi))^2 &= nu laplace (2 nu log(Phi)) + f(t) \
      (diff_t Phi) / Phi - nu ((diff_j Phi) / Phi)^2               &= nu lr([(diff_j^2 Phi) / Phi - ((diff_j Phi) / Phi)^2]) \
      diff_t Phi                                                   &= nu laplace Phi
    $
    And this last equation is the heat equation, which is linear.

  3. The 1D heat equation is $diff_t Phi = nu diff_(x x) Phi$. We assume it is
    defined in a domain $[-L/2, L/2]$ and we equip it with periodic boundary
    conditions. Now we express the solution in Fourier series:
    $
      Phi(x, t) = sum_(n in ZZ) hat(Phi)_n (t) e^((2 pi i n x )/ L)
    $
    Plugging this formula into the equation we get:
    $
      diff_t hat(Phi)_n (t) = - nu ((2 pi n) / L)^2 hat(Phi)_n (t)
    $
    This is a linear ODE, whose solution is $hat(Phi)_n (t) = hat(Phi)_n (0) e^(- nu ((2 pi n) / L)^2 t)$.
    Thus, the solution is:
    $
      Phi(x, t) = sum_(n in ZZ) hat(Phi)_n (0) e^(- nu ((2 pi n) / L)^2 t) e^((2 pi i n x )/ L)
    $
]

#exercice[
  At very large scale, the Universe is described by Newton equations in a flat,
  expanding geometry. The equations are:
  $
    diff_t u_i + dot(a)/a u_i + 1/a u_j diff_j u_i     &= -1/a diff_i Phi\
    diff_t rho + 3 dot(a)/a rho + 1/a diff_j (rho u_j) &= 0 \
    laplace Phi                                        &= 4 pi G a^2 (rho - rho_b)
  $ <eq:31>
  where $a(t)$ is the expansion factor, $Phi$ is the gravitational potential, $rho$ is
  the density and $bold(u)$ us the velocity of the gas. Show that these equations
  can be mapped into the inviscid Burgers equation ($nu = 0$) by using Zeldovich
  transformation:
  $
    V_i = u_i/(a dot(b))           &= - diff_i tilde(Psi)\
    (diff_t + 2 dot(a)/a) diff_t b &= 4 pi G rho_b (t) b\
    tilde(Phi)                     &= Phi / (4 pi G rho_b a^2 b) \
    tilde(Phi)                     &=tilde(Psi)
  $
]
#solution[
  We have that $u_i = -a dot(b) diff_i (tilde(Psi))$. Then, introducing this into
  the equation for $u_i$, we have:
  $
    diff_t u_i + dot(a)/a u_i + 1/a u_j diff_j u_i                                                                                                                                                 &= -1/a diff_i Phi\
    -dot(a)dot(b)diff_i (tilde(Psi)) - a ddot(b) diff_i tilde(Psi) - a dot(b) diff_t diff_i (tilde(Psi)) - dot(a) dot(b) diff_i tilde(Psi) + a dot(b)^2 diff_j tilde(Psi) diff_j diff_i tilde(Psi) &= -4 pi G rho_b a b diff_i tilde(Phi) \
    -a dot(b) diff_t diff_i tilde(Psi) - 4 pi G rho_b a b diff_i tilde(Phi) + a dot(b)^2 diff_j tilde(Psi) diff_j diff_i tilde(Psi)                                                                &= -4 pi G rho_b a b diff_i tilde(Phi) \
    -a dot(b) diff_t diff_i tilde(Psi) + a dot(b)^2 diff_j tilde(Psi) diff_j diff_i tilde(Psi)                                                                                                     &= 0 \
    -diff_b diff_i tilde(Psi) + diff_j tilde(Psi) diff_j diff_i tilde(Psi)                                                                                                                         &= 0\
    diff_b V_i + V_j diff_j V_i                                                                                                                                                                    &= 0
  $
  which is the inviscid Burgers equation with time-variable $b$.
]
#exercice[
  Burgers equation develop finite time singularities. Let us study this in the 1D
  case.
  1. Use @eq:12 to write an equation for $A=diff_x u$.
  2. Introduce the Lagrangian derivative $upright(D)_t A= diff_t A + u diff_x A$. Use
    1) to find the ordinary differential equation that links $A$ and its Lagrangian
    derivative.
  3. Integrate this equation in the case $nu = 0$, and discuss in which condition
    there is a finite time blow up of $A$.
  4. Use this discussion to explain the features of the Khokhlov solution at $nu -> 0$ (presence
    of positive ramps and no negative ramps).
  5. Can this method be used to study potential blow-up in Euler equation?
]
#solution[
  1. Taking $diff_x$ to 1D Burgers equation $diff_t u + u diff_x u = nu diff_(x x) u$,
    we get:

    $
      diff_t diff_x u + diff_x (u diff_x u) = nu diff_(x x x) u
    $
    Thus:
    $
      diff_t A + u diff_x A = nu diff_(x x) A
    $ <eq:41>

  2. From @eq:41 we get:
    $
      upright(D)_t A + A^2 = nu diff_(x x) A
    $

  3. For $nu = 0$ we have:
    $
      upright(D)_t A + A^2 = 0
    $
    Separating variables, we get:
    $
      dd(A) / A^2 = - dd(t)
    $
    Integrating between $s=t_0$ and $s=t$, we get:
    $
      1/A(t, x(t)) - 1/A_0 &= t - t_0\
      A(t, x(t))           &= A_0 / (1 + (t - t_0) A_0)
    $
    where $A_0 := A(t_0, x(t_0))$. We have a finite time blow up of $A$ at $t = t_0 - 1/A_0$,
    provided that $A_0 != 0$.

  4. For simplicity we take $t_0 = 0$. The derivative of the Khokhlov solution is defined everywhere (expect for $x=0$) for all positive times. Thus, since the blow up is at $t = -1/A_0$, we must have $A_0>0$, which implies that $A(t,x(t))>0$ $forall t>0$, that is, the solution develops positive ramps and no negative ramps.

  5. The 1D Euler equation is $diff_t u + u diff_x u = - diff_x p$. We can use the same method to study potential blow-up in the Euler equation. However, the pressure term will make the analysis more complicated.
]