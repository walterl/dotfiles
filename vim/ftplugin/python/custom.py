import os
import re
import sys
import vim

for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))


BREAKPOINT = 'import ipdb as pdb; pdb.set_trace()'


def eval_buffer():
    eval(compile('\n'.join(vim.current.buffer), '', 'exec'), globals())


def eval_range():
    eval(compile('\n'.join(vim.current.range), '', 'exec'), globals())


def toggle_breakpoint():
    if vim.current.line.lstrip().startswith(BREAKPOINT):
        del vim.current.line
        vim.command('write')
    else:
        set_breakpoint()


def set_breakpoint():
    linenum = int(vim.eval('line(".")'))
    whitespace = re.search('^(\s*)', vim.current.line).group(1)
    mark = '%(m)s Breakpoint %(m)s' % {'m': '#' * 8}
    ins_line = '%s%s  %s' % (whitespace, BREAKPOINT, mark)
    vim.current.buffer.append(ins_line, linenum-1)
    vim.command('write')


def remove_breakpoints():
    current_line = int(vim.eval('line(".")'))

    line_numbers = []
    for i, line in enumerate(vim.current.buffer):
        if line.lstrip().startswith('import ipdb as pdb; pdb.set_trace()'):
            line_numbers.append(i)

    for linenum in reversed(line_numbers):
        del vim.current.buffer[linenum]

    vim.command('normal %dG' % current_line)
    vim.command('write')


def load_venv(venv=None):
    if venv is None and 'VIRTUAL_ENV' in os.environ:
        venv = os.environ['VIRTUAL_ENV']
    if not venv:
        return
    sys.path.insert(0, venv)
    activate_this = os.path.join(venv, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
