# PlutoProfile

[![Build Status](https://github.com/gdalle/PlutoProfile.jl/workflows/CI/badge.svg)](https://github.com/gdalle/PlutoProfile.jl/actions)

Profile functions inside Pluto notebooks without worrying about multiprocessing.

This package exports a single macro, `@plutoprofeview`, which has basically the same effect as `@profview` (from [ProfileSVG.jl](https://github.com/kimikage/ProfileSVG.jl)). The only difference is that `@plutoprofview` filters the flame graph to remove the useless parts where the notebook process is simply waiting on other tasks.

See the [example notebook](https://gdalle.github.io/PlutoProfile.jl/) to understand the difference.
