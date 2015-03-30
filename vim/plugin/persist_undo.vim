" From http://nathan-long.com/blog/vim-a-few-of-my-favorite-things/

if exists("&undodir")
  set undofile
  let &undodir=&directory
  set undolevels=500
  set undoreload=500
endif
