domains
  name = string.
  gender = string.

  number = integer.

predicates
  parent(name, name, gender, gender).
  parentN(name, name, integer, gender).
  sibling(name, name, gender, gender).
  spouse(name, name).
  parentInLaw(name, name, gender, gender).
  auncle(name, name, gender, gender).
  bastard(name, name, gender, gender).

clauses
  parent("B", "A", "Male", "Male").
  parent("C", "A", "Female", "Male").
  parent("D", "B", "Male", "Male").
  parent("E", "B", "Female", "Male").
  parent("F", "C", "Male", "Female").
  parent("G", "C", "Female", "Female").
  parent("B", "A1", "Male", "Female").
  parent("C", "A1", "Female", "Female").
  parent("D", "B1", "Male", "Male").
  parent("E", "B1", "Female", "Male").
  parent("B", "A3", "Male", "Male").



  parentN(Parent, Child, 1, Gender):- parent(Parent, Child, Gender, _), !.
  parentN(ParentNName, ChildName, N, Gender):-
    parent(ParentNName, ParentN_1Name, Gender, _),
    T = N - 1,
    parentN(ParentN_1Name, ChildName, T, Gender).

  sibling(LeftSibling, RightSibling, GenderLeft, GenderRight) :-
    parent(Mother, LeftSibling, "Female", GenderLeft),
    parent(Father, LeftSibling, "Male", GenderLeft),
    parent(Mother, RightSibling, "Female", GenderRight),
    parent(Father, RightSibling, "Male", GenderRight),
    not(LeftSibling=RightSibling).

  spouse(Father, Mother):-
    parent(Father, Child, "Male", Gender),
    parent(Mother, Child, "Female", Gender), !.
  spouse(Mother, Father):-
    spouse(Father, Mother).

  parentInLaw(Parent, Spouse, PGender, SGender):-
    spouse(Spouse, Someone),
    parent(Parent, Spouse, PGender, SGender), !.

  auncle(Auncle, Nibling, AGender, NGender):-
    parent(Parent, Nibling, PGender, NGender),
    sibling(Auncle, Parent, AGender, PGender), !.

  bastard(Parent, Bastard, PGender, BGender):-
    parent(Parent, Bastard, PGender, BGender),
    spouse(Parent, Spouse),
    not(parent(Spouse, Bastard, _, BGender)), !.

goal
  %parentN(ParentNName, "A", 2, "Male").
  %sibling("A", Sibling, "Male", "Female").
  %spouse("B", Wife).
  %parentInLaw(Parent, "B", "Male", "Male").
  %auncle(Uncle, "A", "Male", "Male").
  bastard("B", Bastard, "Male", _).