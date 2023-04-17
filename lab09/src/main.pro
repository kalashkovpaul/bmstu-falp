domains
  name = string.
  gender = string.

  number = integer.

predicates
  parent(name, name, gender).
  grandParent(name, name, gender, gender).

  two_max(number, number, number).
  two_max_cut(number, number, number).
  three_max(number, number, number, number).
  three_max_cut(number, number, number, number).

clauses
  parent("B", "A", "Male").
  parent("C", "A", "Female").
  parent("D", "B", "Male").
  parent("E", "B", "Female").
  parent("F", "C", "Male").
  parent("G", "C", "Female").

  grandParent(GrandParentName, ChildName, GrandParentGender, ParentGender):-
    parent(GrandParentName, ParentName, GrandParentGender),
    parent(ParentName, ChildName, ParentGender).

  two_max(First, Second, First):- First >= Second.
  two_max(First, Second, Second):- First < Second.

  two_max_cut(First, Second, First):- First >= Second, !.
  two_max_cut(_, Second, Second).

  three_max(First, Second, Third, First):- First >= Second, First >= Third.
  three_max(First, Second, Third, Second):- Second >= First, Second >= Third.
  three_max(First, Second, Third, Third) :- Third >= First, Third >= Second.

  three_max_cut(First, Second, Third, First):- First >= Second, First >= Third, !.
  three_max_cut(_, Second, Third, Second):- Second >= Third, !.
  three_max_cut(_, _, Third, Third).



goal
  %grandParent(GrandParentName, "A", "Female", _).
  %grandParent(GrandParentName, "A", "Male", _).
  %grandParent(GrandParentName, "A", _, _).
  %grandParent(GrandParentName, "A", "Female", "Female").
  %grandParent(GrandParentName, "A", _, "Female").
  %two_max(1, 2, MAX).
  %two_max(2, 1, MAX).
  %two_max_cut(1, 2, MAX).
  %two_max_cut(2, 1, MAX).
  %three_max(1, 2, 3, MAX).
  %three_max(3, 2, 1, MAX).
  %three_max(1, 3, 2, MAX).
  %three_max_cut(1, 2, 3, MAX).
  %three_max_cut(3, 2, 1, MAX).
  %three_max_cut(1, 3, 2, MAX).