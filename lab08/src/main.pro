domains
  surname = string.
  phone = integer.
  city = string.
  street = string.
  house = integer.
  flat = integer.
  mark = string.
  color = string.
  price = integer.
  carnumber = string.
  address = addr(city, street, house, flat).
  area = integer.
  floors = integer.
  region = string.
  bankname = string.
  account = integer.
  amount = integer.
  experience = integer.
  buildingname = string.
  sitename = string.
  watervehiclename = string.
  propertyName = string.
  propertyType = string.

  propertyItem =
    auto(propertyName, color, price, carnumber);
    building(propertyName, price, area, floors);
    site(propertyName, price, area, region);
    water_vehicle(propertyName, price, mark, color).


predicates
  record(surname, phone, address)
  property(surname, propertyItem)
  bank(surname, bankname, amount, account, experience)

  property_by_surname(surname, propertyName)
  property_and_price_by_surname(surname, propertyName, price)
  sum_of_prop_price_by_surname(surname, price)
  get_prop_price(surname, propertyType, price)

clauses
  record("Ivanov", 1, addr("Maloyaroslavets", "A", 1, 2)).
  record("Ivanov", 4,  addr("Maloyaroslavets", "A", 1, 2)).
  record("Petrov", 9,  addr("Moscow", "Brusilova", 3, 4)).
  record("Sidorov", 16,  addr("Moscow", "Brusilova", 5, 6)).
  record("Sidorov", 25,  addr("Moscow", "Brusilova", 5, 6)).
  record("Phedorov", 36,  addr("Moscow", "Donskoy 6", 7, 8)).
  record("Phedorov", 49,  addr("Moscow", "Donskoy 6", 7, 8)).
  record("Ivanov", 64,  addr("Mars", "Earth", 9, 10)).

  property("Ivanov", auto("lada", "violet", 150000, "aa000a")).
  property("Petrov", auto("mers", "black", 2000000, "aa002a")).
  property("Sidorov", auto("volga", "rusty", 10000, "bb003b")).
  property("Phedorov", auto("ferra", "red", 15000000, "dd005d")).
  property("Kalashkov", auto("bicycle", "white", 150000, "ff007f")).
  property("Kalashnikov", auto("tank", "black", 155500, "gg008g")).

  property("Ivanov", building("box", 1000, 1, 1)).
  property("Pertov", building("house", 10000000, 250, 3)).

  property("Petrov", site("dacha", 6000000, 600, "Podmoskovie")).
  property("Sidorov", site("fields", 900000000, 50000, "Siberia")).

  property("Sidorov", water_vehicle("waterbike", 100000, "honda", "black")).
  property("Phedorov", water_vehicle("yacht", 80000000, "yamaha", "blue")).

  bank("Ivanov", "Sberbank", 100000, 10000, 3).
  bank("Petrov", "VTB", 10000000, 99999, 15).
  bank("Sidorov", "Centralbank", 150000, 1000, 20).
  bank("Phedorov", "Tinkoff", 8800555, 500000, 1).

  property_by_surname(Surname, PropertyName):-
    property(Surname, auto(PropertyName, _, _, _));
    property(Surname, building(PropertyName, _, _, _));
    property(Surname, site(PropertyName, _, _, _));
    property(Surname, water_vehicle(PropertyName, _, _, _)).

  property_and_price_by_surname(Surname, PropertyName, Price):-
    property(Surname, auto(PropertyName, _, Price, _));
    property(Surname, building(PropertyName, Price, _, _));
    property(Surname, site(PropertyName, Price, _, _));
    property(Surname, water_vehicle(PropertyName, Price, _, _)).

  get_prop_price(Surname, auto, Price) :-
    property(Surname, auto(_, _, Price, _)), !.
  get_prop_price(Surname, building, Price) :-
    property(Surname, building(_, Price, _, _)), !.
  get_prop_price(Surname, site, Price) :-
    property(Surname, site(_, Price, _, _)), !.
  get_prop_price(Surname, water_vehicle, Price) :-
    property(Surname, water_vehicle(_, Price, _, _)), !.
  get_prop_price(_, _, 0).

  sum_of_prop_price_by_surname(Surname, Price):-
    get_prop_price(Surname, auto, AutoPrice),
    get_prop_price(Surname, building, BuildingPrice),
    get_prop_price(Surname, site, SitePrice),
    get_prop_price(Surname, water_vehicle, WVPrice),
    Price = AutoPrice + BuildingPrice + SitePrice + WVPrice.


goal
 %property_by_surname("Ivanov", PropertyName).
 %property_and_price_by_surname("Ivanov", PropertyName, Price).
 %sum_of_prop_price_by_surname("Ivanov", Total).
 %get_prop_price("Ivanov", auto, AutoPrice).