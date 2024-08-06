using StatsPlots
using CSV
using DataFrames

run(`dart compile exe -o run ./bin/dart_random_logo.dart`)
@time o = read(`./run`, String)
data = DataFrame(CSV.File(IOBuffer(o), header=["x", "y"]))

(@df data scatter(:x, :y)) |> display
