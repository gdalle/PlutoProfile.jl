module PlutoProfile

using AbstractTrees
using FlameGraphs
using Profile
using ProfileCanvas

export @plutoprofview

function pluto_subtree(fg)
    for node in PreOrderDFS(fg)
        if (
            endswith(string(node.data.sf.file), "PlutoRunner.jl") &&
            endswith(string(node.data.sf.func), "run_inside_trycatch")
        )
            return node
        end
    end
    return fg
end

# Code taken from ProfileCanvas

function plutoview(
    data=Profile.fetch(), lidict=Profile.getdict(unique(data)); C=false, kwargs...
)
    d = Dict()
    data_u64 = convert(Vector{UInt64}, data)
    if VERSION >= v"1.8.0-DEV.460"
        for thread in ["all", 1:Threads.nthreads()...]
            fg = FlameGraphs.flamegraph(
                data_u64;
                lidict=lidict,
                C=C,
                threads=thread == "all" ? (1:Threads.nthreads()) : thread,
            )
            d[thread] = ProfileCanvas.tojson(pluto_subtree(fg))
        end
    else
        fg = FlameGraphs.flamegraph(data_u64; lidict=lidict, C=C)
        d["all"] = ProfileCanvas.tojson(pluto_subtree(fg))
    end

    return ProfileCanvas.ProfileData(d)
end

"""
    @plutoprofview f(args...) [C = false]
Clear the Profile buffer, profile `f(args...)`, and view the collected profiling data.
The optional `C` keyword argument controls whether functions in C code are displayed.
"""
macro plutoprofview(ex, args...)
    return quote
        Profile.clear()
        Profile.@profile $(esc(ex))
        plutoview(; $(esc.(args)...))
    end
end

end
