#lang scribble/manual


@(require (for-label racket/base))


@title[#:tag "design-recipe" #:version #false]{The Function Design Recipe}

This document is the Function Design Recipe from the textbook How to Design Programs. The design
recipe is a list of steps to follow when creating a new function. Following this recipe will make it
easier to solve programming problems and, crucially, easier to
@emph{explain your solutions to other programmers} when asking them for help.

Whenever you're stuck on a programming problem and not sure what to do or why your code isn't working,
@bold{try following this recipe before asking for help.} Some of the steps include writing down
comments in your code explaining what you're trying to do. That makes it far easier for other
programmers to help you. And as you get better at following this recipe, you might just find yourself
solving difficult problems on your own more and more often.

To those programmers trying to help others, share this design recipe with them. When someone asks you
for help writing a function, ask them to try to follow this design recipe and tell you what step
they're stuck on. Note that you can click the section titles to get links to specific sections. Use
that feature to help guide others through any steps they're struggling with. Remember to be kind:
everyone either underestimates or forgets how much effort it takes to learn how to design programs.


@section[#:tag "data-definition"]{Data Definition}

Before doing anything else, you should @bold{define what data you're working with}. To do this, think
about what kinds of information are relevant to your function. Decide how to represent this
information with ordinary Racket values like numbers, strings, and lists. Then write your decision
down in code. For simple data definitions, a comment or two can suffice:

@(racketblock
  (code:comment @#,elem{A temperature is a number. There are two kinds of temperatures:})
  (code:comment @#,elem{degrees Fahrenheit and degrees Celsius.}))

For more complex data definitions, you might create a @racket[struct] (or several structs) to group
data together into logical units. In these cases, use comments to explain what the struct is and what
its components mean. For example, a function for solving a geometry problem may need a data definition
like this:

@(racketblock
  (code:comment @#,elem{A point is a pair of two numbers: an x-coordinate and a y-coordinate.})
  (struct point (x y) #:transparent))

Always make your structs transparent when they're used to group together data in this fashion. The
ability to make non-transparent structs (called @emph{opaque} structs) is meant for hiding the
struct's data from other code, which is typically not useful for structs that just group data
together. In a better world, Racket's structs would be transparent by default.


@section[#:tag "interface-definition"]{Interface Definition}

The @bold{interface} of your function is @bold{everything that describes what your function does}, but
not how it does it. This includes the name of the function, the names and datatypes of its parameters,
the type of data the function returns, and any comments describing what the function does or how to
use it. These collectively give the reader all the information they need to call the function. In the
code below, the interface of the @racket[fahrenheit-to-celsius] function is everything except for the
ellipses:

@(racketblock
  (code:comment @#,elem{Temperature -> Temperature})
  (code:comment @#,elem{Converts a temperature in degrees Fahrenheit to degrees Celsius})
  (define (fahrenheit-to-celsius fahrenheit)
    ...))

Interfaces have three main pieces: a @bold{signature}, a @bold{purpose statement}, and a
@bold{header}. Write down all three pieces when designing a new function, preferably in that order.
The individual pieces are described in more detail below.


@subsection[#:tag "signature"]{Signature}

The @bold{signature} is the most important part of your function. It describes
@bold{what types of data your function takes as inputs and returns as output.} In simple
untyped Racket, a signature takes the form of a comment with an arrow symbol (->) in it. The types of
the function's parameters are written on the left of the arrow and the type of the function's returned
output is written on the right of the arrow. The @racket[fahrenheit-to-celsius] example above has this
signature:

@(racketblock
  (code:comment @#,elem{Temperature -> Temperature}))

That signature indicates that the function takes a single temperature as an input and returns a single
temperature as an output. And from the data definition we defined earlier, we know that a temperature
is just a number. So the function takes a number and returns a number.

As another example, a function that takes three points describing a triangle and returns the area of
that triangle might have a signature like this:

@(racketblock
  (code:comment @#,elem{Point Point Point -> Number}))

In "real world" Racket, signatures are often written as @tech{contracts} instead of comments. In Typed
Racket, signatures are written with type annotations. These are all different flavors of signatures
and they come with different tools to check that the signatures are correct and that each function is
used properly according to its signature.


@subsection[#:tag "purpose-statement"]{Purpose Statement}

The @bold{purpose statement} is a comment that
@bold{describes what the function does in plain English} (or Spanish, Russian, Chinese, etc.). The
purpose statement should be a short summary that omits details about @emph{how} the function does what
it does. In the @racket[fahrenheit-to-celsius] example above, the purpose statement is:

@(racketblock
  (code:comment @#,elem{Converts a temperature in degrees Fahrenheit to degrees Celsius}))

Notice how the purpose statement does @emph{not} describe the formula for converting from Fahrenheit
to Celsius. It doesn't say "subtracts 32 from the input and then multiplies it by 5/9." Those are
answers to "how does it work?" A purpose statement answers "what does it do?" If you are unsure what
to write for a purpose statement, ask yourself "what does the function compute?" Then write down the
shortest possible answer to that question.

@(racketblock
  (code:comment @#,elem{Converts a temperature in degrees Fahrenheit to degrees Celsius}))


@subsection[#:tag "header"]{Header}

TODO.

@(racketblock
  (define (fahrenheit-to-celsius fahrenheit)
    0))


@section[#:tag "examples"]{Examples}

TODO.


@section[#:tag "implementation-template"]{Implementation Template}

TODO.


@section[#:tag "implementation"]{Implementation}

TODO.


@section[#:tag "testing"]{Testing}

TODO.
