#lang scribble/manual


@(require (for-label racket/base
                     racket/list
                     rackunit)
          scribble/example)


@title[#:tag "design-recipe" #:version #false]{The Function Design Recipe}

@(define recipe-url "https://htdp.org/2023-8-14/Book/part_one.html#%28part._sec~3adesign-func%29")
@(define htdp-url "https://htdp.org/")

This document is the @hyperlink[recipe-url]{Function Design Recipe} from the textbook
@hyperlink[htdp-url]{How to Design Programs}. The design recipe is a list of steps to follow when
creating a new function. Following this recipe will make it easier to solve programming problems and,
crucially, easier to @emph{explain your solutions to other programmers} when asking them for help.

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

For more complex data definitions, you might create a struct (or several structs) using
@racket[define-struct] to group data together into logical units. In these cases, use comments to
explain what the struct is and what its components mean. For example, a function for solving a
geometry problem may need a data definition like this:

@(racketblock
  (code:comment @#,elem{A point is a pair of two numbers: an x-coordinate and a y-coordinate.})
  (define-struct point (x y) #:transparent))

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

That signature indicates that the function takes a @bold{single temperature as an input} and returns a
@bold{single temperature as an output}. And from the data definition we defined earlier, we know that
@bold{a temperature is just a number}. So the function takes a number and returns a number.

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

@subsection[#:tag "header"]{Header}

The @bold{header} is a simple definition of the function with an unfinished implementation that does
as little as possible. The goal of the header is to define the function's name and the name of its
parameters @emph{in code}, as contrasted with the signature and purpose statement which define the
function @emph{in text}. The header is written with @racket[define], followed by the function's name
and the names of its parameters, then finally a trivial value such as @racket[0], @racket[#false], or
the empty list is used. Choose the trivial value that matches the type of output your function is
meant to return. Refer to your function's signature if you've forgotten what that type is; you should
have written the return type down to the right of the arrow in the signature. For our
@racket[fahrenheit-to-celsius] function, the following is a suitable header:

@(racketblock
  (define (fahrenheit-to-celsius fahrenheit)
    0))

Once you've written a signature, purpose statement, and header, you should be able to run your code
(by clicking the Run button in DrRacket) without producing any errors. This is a big milestone: your
function may not do anything useful yet, but it does @emph{exist} and you have clearly stated what
it's @emph{supposed} to do. @bold{Please complete these steps at a minimum before asking for help!}
It's incredibly difficult for other programmers to help you fix your code if they don't know what
you're @emph{intending} your code to do. Finishing these steps will save a lot of time as other
programmers won't have to ask you dozens of questions to try and understand what you're trying to do.


@section[#:tag "examples"]{Examples}

Putting together the previous sections, here's what we have so far:

@(racketblock
  (code:comment @#,elem{A temperature is a number. There are two kinds of temperatures:})
  (code:comment @#,elem{degrees Fahrenheit and degrees Celsius.})
  (code:line)
  (code:comment @#,elem{Temperature -> Temperature})
  (code:comment @#,elem{Converts a temperature in degrees Fahrenheit to degrees Celsius})
  (define (fahrenheit-to-celsius fahrenheit)
    0))

We have clearly stated what our function is supposed to do. However, we have mearly written down
descriptions and names. As in all cases of explanation, it is best to include @emph{examples}. To do
so, @bold{write down a comment} showing what the @bold{correct output} of the function is for an
@bold{example input} (or inputs, if the function has multiple parameters). For example, here's how we
would explain that an input temperature of 86 degrees Fahrenheit should return an output temperature
of 30 degrees Celsius:

@(racketblock
  (code:comment @#,elem{A temperature is a number. There are two kinds of temperatures:})
  (code:comment @#,elem{degrees Fahrenheit and degrees Celsius.})
  (code:line)
  (code:comment @#,elem{Temperature -> Temperature})
  (code:comment @#,elem{Converts a temperature in degrees Fahrenheit to degrees Celsius})
  (code:comment @#,elem{given: 86, expect: 30})
  (define (fahrenheit-to-celsius fahrenheit)
    0))

Examples are extremely effective in helping others understand your code. Words describing what a
function does can be vague and ambiguous, but examples are explicit and precise.


@section[#:tag "implementation-template"]{Implementation Template}

@(define owl-url "https://i.kym-cdn.com/photos/images/original/000/572/078/d6d.jpg")

In this step, we --- finally --- shift our attention to the @emph{body} of the function. However,
going from the trivial function body we wrote in the header step to a fully working implementation is
a bit of an @hyperlink[owl-url]{owl-drawing exercise}. To break this process down, first we will write
a @emph{template}.

A template is a @bold{partial snippet of code} following some @bold{common pattern} based on the
@bold{types} of the inputs to a function and its output. In the case of our
@racket[fahrenheit-to-celsius] function, we know three things about our input and output:

@itemlist[
 @item{We have one input, named @racket[fahrenheit], and it's a number representing a temperature.}
 @item{We need to produce a number representing a temperature in Celsius as output.}
 @item{We have to @emph{compute} the output from the input. The formula converting fahrenheit to
  celsius involves subtraction and multiplication, so we'll need to use those.}]

From this, we might write the following function body using a template for calling the needed math
functions on @racket[fahrenheit]:

@(racketblock
  (define (fahrenheit-to-celsius fahrenheit)
    (... - ... * ... fahreneit ...)))

When writing templates, use @racket[...] to fill in for code we aren't sure about yet. So far we know
we probably need to use the @racket[-] or @racket[*] functions to do some math, and we need to pass
@racket[fahrenheit] as input to those functions. The rest is up in the air, but now we have a starting
point.

Templates tend to be more useful the more complex the input data is. For example, a common template
when writing functions that process @emph{lists} is to use @racket[cond] and @racket[empty?] to check
if the list is empty, and do something with the first element of the list and the rest of the list if
it's not. If we were trying to write a function that doubles every number in a list, using that
template for lists might give us a definition like the following:

@(racketblock
  (code:comment @#,elem{A list of numbers, spelled ListOfNumbers, is a collection of some quantity})
  (code:comment @#,elem{of numbers. A list may be empty. If a list is not empty, it has a first})
  (code:comment @#,elem{number and a smaller list containing the rest of the numbers.})
  (code:line)
  (code:comment @#,elem{ListOfNumbers -> ListOfNumbers})
  (code:comment @#,elem{Doubles every number in a list})
  (code:comment @#,elem{given: (list 1 2 3), expect: (list 2 4 6)})
  (define (double-each-number numbers)
    (cond
      [(empty? numbers) ...]
      [else
       (... (first numbers) ... (rest numbers) ...)])))


@section[#:tag "implementation"]{Implementation}

In this step, we fill in the rest of the function's implementation. The template from the previous
step should use ellipses (the @racket[...] symbol) to identify what pieces need to be filled in. Go
through the template's ellipses one at a time and decide what code to fill in. For our
@racket[fahrenheit-to-celsius] function, we had the following implementation template:

@(racketblock
  (... - ... * ... fahreneit ...))

The formula for converting a fahrenheit temperature F to celsius is (F - 32) * 5/9. Notice the
subtraction is nested inside parentheses: that means that it should also be nested in our template.
The outermost operation is multiplication, so it should go in the outermost layer of our function
body.

@(racketblock
  (* (- fahrenheit ...) ...))

Now we fill in the constant @racket[32] for the subtraction.

@(racketblock
  (* (- fahrenheit 32) ...))

And fill in @racket[5/9] for the multiplication.

@(racketblock
  (* (- fahrenheit 32) 5/9))

We have now implemented our function! The result of our work looks like this:

@(racketblock
  (code:comment @#,elem{A temperature is a number. There are two kinds of temperatures:})
  (code:comment @#,elem{degrees Fahrenheit and degrees Celsius.})
  (code:line)
  (code:comment @#,elem{Temperature -> Temperature})
  (code:comment @#,elem{Converts a temperature in degrees Fahrenheit to degrees Celsius})
  (code:comment @#,elem{given: 86, expect: 30})
  (define (fahrenheit-to-celsius fahrenheit)
    (* (- fahrenheit 32) 5/9)))

We're not done yet however. We may have implemented our function, but now we must @emph{test} it.


@section[#:tag "testing"]{Testing}


The final step in the function design recipe is testing the function to be sure it works. There are
two approaches to testing functions: @emph{manual} testing and @emph{automated} testing. Manual
testing is simpler, but requires more work and is more prone to errors.

To manually test your function, click the Run button in DrRacket. Then, in the Interactions Window,
call your function with the examples you wrote down in the Examples step of the design recipe. Here's
an example of how manually testing @racket[fahrenheit-to-celsius] would look:

@(examples
  (eval:alts (fahrenheit-to-celsius 86) (eval:result @racketresultfont{30})))

An automated test of your function is similar to a manual test, except instead of manually calling
your function in the Interactions Window each time you want to test your function, you write a
@emph{test case} that will automatically test your function each time you press Run. This is called
@emph{unit testing}, and each test case is called a @emph{unit test}. There are many different ways to
write unit tests. The most common way in Racket code is using the @racketmodname[rackunit] test
framework. To use RackUnit, write a @emph{test submodule} below your function like so:

@(racketblock
  (define (fahrenheit-to-celsius fahrenheit)
    (* (- fahrenheit 32) 5/9))

  (module+ test
    (require rackunit)
    ...))

The test submodule is where we'll place our tests. We'll use @racket[check-equal?] to test that
calling our function with 86 produces the expected result of 32:

@(racketblock
  (define (fahrenheit-to-celsius fahrenheit)
    (* (- fahrenheit 32) 5/9))

  (module+ test
    (require rackunit)
    (check-equal? (fahrenheit-to-celsius 86) 32)))

Now, whenever you press Run in DrRacket, your test will run automatically. This is very useful when
trying to change old code or when working together with other programmers on code, as it ensures you
don't accidentally break something without realizing it.