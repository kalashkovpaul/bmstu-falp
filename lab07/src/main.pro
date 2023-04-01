domains
  city = string.
  street = string.
  house = integer.
  flat = integer.
  adress = addr(city, street, house, flat).

predicates
  record(string, integer, adress)
  auto(string, string, string, integer, string)

clauses
  record("Ivanov", 131, addr("Maloyaroslavets", "A", 1, 2)).
  record("Ivanov", 222,  addr("Maloyaroslavets", "A", 1, 2)).
  record("Petrov", 341,  addr("Moscow", "Brusilova", 3, 4)).
  record("Sidorov", 441,  addr("Moscow", "Brusilova", 5, 6)).
  record("Sidorov", 476,  addr("Moscow", "Brusilova", 5, 6)).
  record("Phedorov", 544,  addr("Moscow", "Donskoy 6", 7, 8)).
  record("Phedorov", 194,  addr("Moscow", "Donskoy 6", 7, 8)).
  record("Ivanov", 656,  addr("Mars", "Earth", 9, 10)).

  auto("Ivanov", "lada", "violet", 150000, "aa000a").
  auto("Ivanov", "reno", "green", 1532100, "aa001a").
  auto("Petrov", "mers", "black", 2000000, "aa002a").
  auto("Sidorov", "volga", "rusty", 10000, "bb003b").
  auto("Sidorov", "porsh", "yellow", 1009900, "cc004c").
  auto("Phedorov", "ferra", "red", 15000000, "dd005d").
  auto("Phedorov", "porsh", "grey", 124000, "ee006e").
  auto("Ivanov", "bicycle", "white", 150000, "ff007f").
  auto("Ivanov", "tank", "black", 155500, "gg008g").


goal
 % auto(Name, "lada", "violet", _, _).
 % auto(Name, "porsh", "grey", _, _), record(Name, Phone,  addr(Town, _, _, _)).