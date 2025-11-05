use context starter2024
data TaxonomyTree:
  node(rank :: String, name :: String, children :: List<TaxonomyTree>)
end

# Example: Part of the cat family
lion = node("Species", "Panthera leo", [list: ])
tiger = node("Species", "Panthera tigris", [list: ])
leopard = node("Species", "Panthera pardus", [list: ])
panthera = node("Genus", "Panthera", [list: lion, tiger, leopard])

house-cat = node("Species", "Felis catus", [list: ])
wildcat = node("Species", "Felis silvestris", [list: ])
felis = node("Genus", "Felis", [list: house-cat, wildcat])

felidae = node("Family", "Felidae", [list: panthera, felis])


fun count-nodes(t :: TaxonomyTree) -> Number:
   1 + count-nodes-children(t.children)
where:
  count-nodes(lion) is 1
  count-nodes(panthera) is 4
  count-nodes(felis) is 3
  count-nodes(felidae) is 8
end

fun count-nodes-children(c :: List<TaxonomyTree>) -> Number:
  cases (List) c:
    | empty => 0
    | link(first, rest) =>
      count-nodes(first) + count-nodes-children(rest)
  end
end

fun count-leaves(t :: TaxonomyTree) -> Number:
  cases (List) t.children:
    | empty => 1
    | else => count-leaves-children(t.children)
  end
where:
  count-leaves(lion) is 1
  count-leaves(panthera) is 3
  count-leaves(felis) is 2
  count-leaves(felidae) is 5
end

fun count-leaves-children(c :: List<TaxonomyTree>) -> Number:
  cases (List) c:
    | empty => 0
    | link(first, rest) =>
      count-leaves(first) + count-leaves-children(rest)
  end
end

# PROBLEM 1: Design a function count-species that takes a TaxonomyTree and counts the number of nodes with the rank Species
fun count-species(t :: TaxonomyTree) -> Number:
  doc: "counts the number of nodes with the rank species"
  if t.rank == "Species":
    1 + c-s(t.children)
  else:
    c-s(t.children)
  end
where:
  count-species(felidae) is 5
  count-species(panthera) is 3
end

fun c-s(t) -> Number:
  cases (List) t:
      | empty => 0
      | link(f, r) => count-species(f) + c-s(r)
  end
end


# PROBLEM 2: Design a function count-rank which takes a TaxonomyTree and a rank string that returns the number of nodes with that rank.
fun count-rank(t :: TaxonomyTree, rk :: String) -> Number:
  doc: "counts the number of nodes with that rank"
  if t.rank == rk:
    1 + c-r(t.children, rk)
  else:
    c-r(t.children, rk)
  end
where: 
  count-rank(felidae, "Species") is 5
  count-rank(felidae, "Genus") is 2
end

fun c-r(t, rk) -> Number:
  cases (List) t:
    | empty => 0
    | link(f, r) => count-rank(f, rk) + c-r(r, rk)
  end
end

  

# PROBLEM 3: Design a function taxon-height that returns the number of levels in the TaxonomyTree (root is level 1).




# PROBLEM 4: Design a function all-names that returns a list of all names in the TaxonomyTree (duplicates are okay). You'll need an all-names and all-names-list functions.


