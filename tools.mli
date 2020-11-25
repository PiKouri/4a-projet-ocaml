open Graph

val clone_nodes: 'a graph -> 'b graph
val gmap: 'a graph -> ('a -> 'b) -> 'b graph
val add_arc: int graph -> id -> id -> int -> int graph
val adjacent_nodes : 'a graph -> id -> id list
val graph_length : 'a graph -> int
