module PlutoProfile

using AbstractTrees
using FlameGraphs
using Profile
using ProfileSVG

export @plutoprofview

function pluto_subtree(g)
    for n in PreOrderDFS(g)
        if (
            endswith(string(n.data.sf.file), "PlutoRunner.jl") &&
            endswith(string(n.data.sf.func), "run_inside_trycatch")
        )
            return n
        end
    end
    return g
end

"""
    @plutoprofview f(args...)
Clear the Profile buffer, profile `f(args...)`, and view the result graphically excluding artefacts due to Pluto's use of multiprocessing.
"""
macro plutoprofview(ex)
    return quote
        Profile.clear()
        @profile $(esc(ex))
        ProfileSVG.view(pluto_subtree(flamegraph()))
    end
end

end
