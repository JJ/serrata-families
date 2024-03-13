require(igraph)
data("colleganza.pairs.date")
default.graph <- graph_from_data_frame(colleganza.pairs.date, directed=F)
all.vertices <- length(V(default.graph))

test_that("colleganza dataset is sliced correctly", {
  all.contracts <- colleganza.slice()
  expect_is(all.contracts, "igraph")
  expect_equal(length(V(all.contracts)), all.vertices)
})
