module Combine where


f :: (a, b) -> (c, d) -> ((b, d), (a, c))
f tuple1 tuple2 = ((snd tuple1, snd tuple2), (fst tuple1, fst tuple2))