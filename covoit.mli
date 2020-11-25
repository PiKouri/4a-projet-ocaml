open Graph
open Gfile
open Ffalgorithm
open Tools

type path = string

val from_file_to_covoit : path -> int graph

val covoit : path -> ((int*int) graph * int)
