### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 54fed622-0b1f-11ec-1987-2db84b3dfb4f
begin
    import Pkg
    # activate a temporary environment
    Pkg.activate(mktempdir())
    
	Pkg.add("ProfileSVG")
	Pkg.add(url="https://github.com/gdalle/PlutoProfile.jl")	
    using PlutoProfile, ProfileSVG
end

# ╔═╡ 1f43857d-e3d2-4927-b2ba-03d983dee7cd
md"""
Define a dummy test function.
"""

# ╔═╡ 173cc0f5-5d57-4ce2-9d8f-72d5995db5c3
function profile_test(n)
    for i = 1:n
        A = randn(100,100,20)
        m = maximum(A)
        Am = mapslices(sum, A; dims=2)
        B = A[:,:,5]
        Bsort = mapslices(sort, B; dims=1)
        b = rand(100)
        C = B.*b
    end
end

# ╔═╡ 8b92bd93-9a5d-48bd-94e2-c57638571d67
md"""
Run it once to precompile.
"""

# ╔═╡ 943949fd-c12c-4f9b-b26a-48e4891431e9
profile_test(1)

# ╔═╡ 85ca4fea-386e-4d87-a7ba-b32263a6df0c
md"""
Profile and visualize the flame graph using `ProfileSVG.@profview`.
"""

# ╔═╡ f0afdc27-2d5d-418e-b0a6-c8960abfe58d
@profview profile_test(10)

# ╔═╡ ec802f21-bcff-4fc3-b391-fc12bb8265d2
md"""
Profile and visualize the flame graph using `PlutoProfile.@plutoprofview`.
"""

# ╔═╡ b57caa51-03fb-445c-9a36-ce5d8c912947
@plutoprofview profile_test(10)

# ╔═╡ Cell order:
# ╠═54fed622-0b1f-11ec-1987-2db84b3dfb4f
# ╟─1f43857d-e3d2-4927-b2ba-03d983dee7cd
# ╠═173cc0f5-5d57-4ce2-9d8f-72d5995db5c3
# ╟─8b92bd93-9a5d-48bd-94e2-c57638571d67
# ╠═943949fd-c12c-4f9b-b26a-48e4891431e9
# ╟─85ca4fea-386e-4d87-a7ba-b32263a6df0c
# ╠═f0afdc27-2d5d-418e-b0a6-c8960abfe58d
# ╟─ec802f21-bcff-4fc3-b391-fc12bb8265d2
# ╠═b57caa51-03fb-445c-9a36-ce5d8c912947
