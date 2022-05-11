# PlutoProfile

[![Build Status](https://github.com/gdalle/PlutoProfile.jl/workflows/CI/badge.svg)](https://github.com/gdalle/PlutoProfile.jl/actions)

Profile functions inside Pluto notebooks.

This package exports a single macro, `@plutoprofview`, which has basically the same effect as `@profview` from [ProfileCanvas.jl](https://github.com/pfitzseb/ProfileCanvas.jl).
The only difference is that `@plutoprofview` filters the profiling flame graph to remove the useless top part, in which the notebook process is simply waiting on other tasks or calling Pluto internals.
