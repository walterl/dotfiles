" Based on https://stackoverflow.com/a/55560276

" Create a NEW matchgroup for each htmlH* region
syn region htmlH1 matchgroup=markdownH1 start="^\s*#"      end="$" contains=mkdLink,mkdInlineURL,@Spell
syn region htmlH2 matchgroup=markdownH2 start="^\s*##"     end="$" contains=mkdLink,mkdInlineURL,@Spell
syn region htmlH3 matchgroup=markdownH3 start="^\s*###"    end="$" contains=mkdLink,mkdInlineURL,@Spell
syn region htmlH4 matchgroup=markdownH4 start="^\s*####"   end="$" contains=mkdLink,mkdInlineURL,@Spell
syn region htmlH5 matchgroup=markdownH5 start="^\s*#####"  end="$" contains=mkdLink,mkdInlineURL,@Spell
syn region htmlH6 matchgroup=markdownH6 start="^\s*######" end="$" contains=mkdLink,mkdInlineURL,@Spell

" Highlight each heading's new matchgroup (the leading #s) differently
highlight markdownH1 ctermfg=34  guifg=Green3
highlight markdownH2 ctermfg=32  guifg=Gold1
highlight markdownH3 ctermfg=127 guifg=Turquoise2
highlight markdownH4 ctermfg=45  guifg=Magenta3
highlight markdownH5 ctermfg=220 guifg=DeepSkyBlue3
highlight markdownH6 ctermfg=208 guifg=DarkOrange
" guifg values from https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim

""""""""""""""""""""""""""""""""""""""""""""""""""
" Another approach: set matchgroup=NONE for htmlH* syntax groups so that
" matches (the leading #s) are highlighted as part of the group.
" This has the downside side effect of highlighting the entire line, delimeter
" AND heading title.

"syn region htmlH1       matchgroup=NONE     start="^\s*#"                   end="$" contains=mkdLink,mkdInlineURL,@Spell
"syn region htmlH2       matchgroup=NONE     start="^\s*##"                  end="$" contains=mkdLink,mkdInlineURL,@Spell
"syn region htmlH3       matchgroup=NONE     start="^\s*###"                 end="$" contains=mkdLink,mkdInlineURL,@Spell
"syn region htmlH4       matchgroup=NONE     start="^\s*####"                end="$" contains=mkdLink,mkdInlineURL,@Spell
"syn region htmlH5       matchgroup=NONE     start="^\s*#####"               end="$" contains=mkdLink,mkdInlineURL,@Spell
"syn region htmlH6       matchgroup=NONE     start="^\s*######"              end="$" contains=mkdLink,mkdInlineURL,@Spell
