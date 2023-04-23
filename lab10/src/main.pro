domains
  num = integer.

predicates
  factorial(num, num). % num, result
  factorial(num, num, num).

  fibonacci(num, num).
  fibonacci(num, num, num, num).

clauses
  factorial(0, 1) :- !. % 0! = 1
  factorial(N, Result) :-
    factorial(N, 1, Result).
  factorial(1, Result, Result) :- !.
  factorial(Number, Current, Result) :-
    Next = Number - 1,
    Multiplication = Number * Current,
    factorial(Next, Multiplication, Result).

  fibonacci(0, 1) :- !.
  fibonacci(1, 1) :- !.
  fibonacci(N, Result) :-
    N_1 = N - 1,
    fibonacci(N_1, 1, 1, Result).
  fibonacci(0, _, Result, Result) :- !.
  fibonacci(N, Double_Prev, Prev, Result) :-
    N_1 = N - 1,
    Next_Double_Prev = Prev,
    Next_Prev = Prev + Double_Prev,
    fibonacci(N_1, Next_Double_Prev, Next_Prev, Result).

goal
  %factorial(3, Result).
  %factorial(6, Result).
  %factorial(0, Result).

  %fibonacci(0, Result).
  %fibonacci(2, Result).
  fibonacci(20, Result).