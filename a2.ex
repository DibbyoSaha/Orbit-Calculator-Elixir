defmodule A2 do
  @moduledoc """
  Documentation for `A2`.
  """

  @doc """
  Assignment 2 - Orbits

  """
  def process(input) do
    strlist = input|>breakString
    strListSpace = breakStringSpace(strlist)
    mapOrbits = %{}
    mapOrbits = threeString(strlist, mapOrbits)
    str = ""
    list = []
    list = temp(strListSpace, mapOrbits)
    list = Enum.filter(list, & !is_nil(&1))
    List.to_string(list)
  end

  def temp(strListSpace, mapOrbits) do
  list = []
    for index <- 0..(Enum.count(strListSpace) - 1) do
      if Enum.count(Enum.at(strListSpace, index)) != 3 do
        if Enum.count(Enum.at(strListSpace, index)) == 2 do
          elem = Enum.at(strListSpace, index) 
          list = list ++ answer(strListSpace, mapOrbits, elem)
        else
          elem = Enum.at(strListSpace, index) 
          list = list ++ oneString(mapOrbits, Enum.at(elem, 0))
        end
      end
    end
  end

  def traverse([head | tail], str, strListSpace, mapOrbits) do
    count = Enum.count(head)
    if [head | tail] == [] do
      str
    else
      head1 = head
      str = answer(strListSpace, mapOrbits, head1) <> "\n"
      traverse(tail, str, strListSpace, mapOrbits)
    end
  end
  
  def answer(strListSpace, mapOrbits, elem) do
  count = Enum.count(elem)
      if Enum.count(elem) == 1 do
        str = oneString(mapOrbits, Enum.at(elem, 0))
        str
      end

      if Enum.count(elem) == 2 do
        if Enum.at(elem, 0) != "Sun" && Enum.at(elem, 1) != "Sun" do
          from = Enum.at(elem, 0)
          to = Enum.at(elem, 1)
          sum = 0
          ans1 = distance(strListSpace, mapOrbits, from)
          ans2 = distance(strListSpace, mapOrbits, to)
          ans = ans1 ++ ans2
          a = (ans -- (ans |> Enum.uniq())) |> Enum.uniq()
          ansn = Enum.filter(ans,fn x -> x != Enum.at(a, 0) end)
          sum = Enum.sum(ansn)
          str = "From " <> from <> " to " <> to <> " is " <> Integer.to_string(sum) <> "km" <> "\n"
        else
          if Enum.at(elem, 0) == "Sun" do
            to = Enum.at(elem, 1)
            sum = 0
            ans1 = distance(strListSpace, mapOrbits, to)
            sum = Enum.sum(ans1)
            str = "From " <> "Sun" <> " to " <> to <> " is " <> Integer.to_string(sum) <> "km" <> "\n"
          else 
            to = Enum.at(elem, 0)
            sum = 0
            ans1 = distance(strListSpace, mapOrbits, to)
            sum = Enum.sum(ans1)
            str = "From " <> to <> " to " <> "Sun" <> " is " <> Integer.to_string(sum) <> "km" <> "\n"
          end
        end
      end
  end

  def distance(strListSpace, mapOrbits, key) do
    secondlist = [key]
    secondlist = secondlist ++ String.split(recursion(mapOrbits, key), " ", trim: true)
    a = 0
    for n <- 0..(Enum.count(secondlist) - 2) do
      orbiter = Enum.at(secondlist, n)
      orbited = Enum.at(secondlist, n+1)
      a = removeNil(searchString(strListSpace, orbiter, orbited))
      a
    end
  end

  def searchString(strListSpace, orbiter, orbited) do
    len = Enum.count(strListSpace)
    for n <- 0..len - 1 do
      lst = Enum.at(strListSpace, n)
      if (Enum.at(lst, 0) == orbiter && Enum.at(lst, 2) == orbited) || (Enum.at(lst, 2) == orbiter && Enum.at(lst, 0) == orbited) do
        lst = Enum.at(lst, 1)
        lst
      end
    end
  end

  def removeNil(list) do
    listNoNil = Enum.filter(list, & !is_nil(&1))
    ans = String.to_integer(List.to_string(listNoNil))
    ans
  end

  def breakStringSpace(list) do
    return = []
    for x <- list do
      return = return ++ String.split(x, " ", trim: true)
      return
    end 
  end

  def oneString(list, key) do
    string = key <> " orbits" <> recursion(list, key) <> "\n"
    string
  end

  def recursion(list, key) do
    str = ""
    lst = list
    if value(lst, key) == nil do
      str
    else
      tempV = value(lst, key)
      str = str <> " " <> tempV <> recursion(lst, tempV)
      str
    end
  end

  def value(mapOrbits, str) do
    result = search(mapOrbits, str)
    result[str]
  end

  def search(list, str) do
    Enum.find(list, fn map -> map[str] != nil end)
  end

  def threeString(strlist, mapOrbits) do
    len = Enum.count(strlist)
    for n <- 0..len - 1 do
      lst = []
      lst = String.split(Enum.at(strlist, n), " ", trim: true)
      if Enum.count(lst) == 3 do
        [first, second, third] = lst
        mapOrbits = Map.put(mapOrbits, third, first)
        mapOrbits
      end
    end
  end

  def breakString(str) do
    listAll = String.split(str, "\n", trim: true)
    listAll
  end

  def main() do
    IO.read(:stdio, :all)
    |> process()
    |> IO.write()
  end
end
