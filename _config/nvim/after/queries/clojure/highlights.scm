(map_lit
 open: "{" @MapDelim
 close: "}" @MapDelim)

(vec_lit
 open: "[" @VecDelim
 close: "]" @VecDelim)

(set_lit
 marker: "#" @SetDelim
 open: "{" @SetDelim
 close: "}" @SetDelim)
