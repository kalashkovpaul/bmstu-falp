domains
  num = integer.
  list = num*.

predicates
  len(list, integer).
  len(list, integer, integer).

  sum(list, integer).
  sum(list, integer, integer).

  sumOdd(list, integer).
  sumOdd(list, integer, integer).

  biggerThan(list, integer, list).

  remove(list, num, list).

  myConcat(list, list, list).

clauses
  len(List, Result) :- len(List, 0, Result).
  len([], Result, Result) :- !.
  len([_|T], Cur, Result) :-
    NextCur = Cur + 1,
    len(T, NextCur, Result).

  sum(List, Result) :- sum(List, 0, Result).
  sum([], Result, Result) :- !.
  sum([H|T], Cur, Result) :-
    NextCur = Cur + H,
    sum(T, NextCur, Result).

  sumOdd(List, Result) :- sumOdd(List, 0, Result).
  sumOdd([], Result, Result) :- !.
  sumOdd([_], Result, Result) :- !.
  sumOdd([_, H|[T]], Cur, Result) :-
    NextCur = Cur + H,
    sumOdd(T, NextCur, Result).

  biggerThan([], _, []) :- !.
  biggerThan([H|T], Border, [H|ResT]) :-
    H > Border,
    biggerThan(T, Border, ResT), !.
  biggerThan([_|T], Border, Result) :-
    biggerThan(T, Border, Result).

  remove([], _, []) :- !.
  remove([El|T], El, Result) :-
    remove(T, El, Result), !.
  remove([H|T], El, [H|ResT]) :-
    remove(T, El, ResT).

  myConcat([], List, List).
  myConcat([H|T], List, [H|ResT]) :-
    myConcat(T, List, ResT).

goal
  %len([1, 2, 3], Result).
  %sum([1, 2, 3], Result).
  %sumOdd([1, 2, 3], Result).
  %biggerThan([1, 2, 3, 4, 5, 6, 7, 8], 4, Result).
  %remove([1, 2, 3, 4, 5, 6, 7, 8], 4, Result).
  %myConcat([1, 2, 3], [4, 5, 6], Result).