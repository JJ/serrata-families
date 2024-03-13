require(igraph)

default.graph <- graph_from_data_frame(colleganza.pairs.date, directed=F)
all.vertices <- length(V(default.graph))

test_that("colleganza dataset is sliced correctly", {
  all.contracts <- colleganza.slice()
  expect_type(all.contracts, "list")
  expect_equal(length(V(all.contracts)), all.vertices)

  pre.serrata.contracts <- colleganza.slice(to=1261)
  expect_lt(length(V(pre.serrata.contracts)), all.vertices)
  post.serrata.contracts <- colleganza.slice(from=1310)
  expect_lt(length(V(post.serrata.contracts)), all.vertices)
})
