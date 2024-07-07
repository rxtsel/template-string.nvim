if exists('g:loaded_template_string')
  finish
endif

lua require'template-string'.setup()

let g:loaded_template_string = 1
