defmodule A2Test do
  use ExUnit.Case
  doctest A2

  def solarSystem do
"Sun 57909227 Mercury
Earth 384400 Moon
Sun 149598262 Earth
Moon 1757 LROrbiter
Mars 9376 Phobos
Mars 23458 Deimos
Sun 227943824 Mars
Sun 778340821 Jupiter
Sun 1426666422 Saturn
Sun 2870658186 Uranus
Sun 4498396441 Neptune
"
  end

  test "default example" do
    assert solarSystem() <>
  "Sun Moon
Deimos Moon
Deimos
Deimos Phobos
Moon
LROrbiter
Mercury Moon
Saturn Moon
Saturn
Uranus Mars
Mars
Mercury
Jupiter Moon
Neptune Moon
Jupiter
LROrbiter Mars
Neptune
Uranus
" |> A2.process() == "From Sun to Moon is 149982662km
From Deimos to Moon is 377949944km
Deimos orbits Mars Sun
From Deimos to Phobos is 32834km
Moon orbits Earth Sun
LROrbiter orbits Moon Earth Sun
From Mercury to Moon is 207891889km
From Saturn to Moon is 1576649084km
Saturn orbits Sun
From Uranus to Mars is 3098602010km
Mars orbits Sun
Mercury orbits Sun
From Jupiter to Moon is 928323483km
From Neptune to Moon is 4648379103km
Jupiter orbits Sun
From LROrbiter to Mars is 377928243km
Neptune orbits Sun
Uranus orbits Sun
"
  end 
end
