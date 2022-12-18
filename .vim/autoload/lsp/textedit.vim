vim9script

import './util.vim'

# sort the list of edit operations in the descending order of line and column
# numbers.
# 'a': {'A': [lnum, col], 'B': [lnum, col]}
# 'b': {'A': [lnum, col], 'B': [lnum, col]}
def Edit_sort_func(a: dict<any>, b: dict<any>): number
  # line number
  if a.A[0] != b.A[0]
    return b.A[0] - a.A[0]
  endif
  # column number
  if a.A[1] != b.A[1]
    return b.A[1] - a.A[1]
  endif

  return 0
enddef

# Replaces text in a range with new text.
#
# CAUTION: Changes in-place!
#
# 'lines': Original list of strings
# 'A': Start position; [line, col]
# 'B': End position [line, col]
# 'new_lines' A list of strings to replace the original
#
# returns the modified 'lines'
def Set_lines(lines: list<string>, A: list<number>, B: list<number>,
					new_lines: list<string>): list<string>
  var i_0: number = A[0]

  # If it extends past the end, truncate it to the end. This is because the
  # way the LSP describes the range including the last newline is by
  # specifying a line number after what we would call the last line.
  var numlines: number = lines->len()
  var i_n = [B[0], numlines - 1]->min()

  if i_0 < 0 || i_0 >= numlines || i_n < 0 || i_n >= numlines
    #util.WarnMsg("set_lines: Invalid range, A = " .. A->string()
    #		.. ", B = " ..  B->string() .. ", numlines = " .. numlines
    #		.. ", new lines = " .. new_lines->string())
    var msg = "set_lines: Invalid range, A = " .. A->string()
    msg ..= ", B = " ..  B->string() .. ", numlines = " .. numlines
    msg ..= ", new lines = " .. new_lines->string()
    util.WarnMsg(msg)
    return lines
  endif

  # save the prefix and suffix text before doing the replacements
  var prefix: string = ''
  var suffix: string = lines[i_n][B[1] :]
  if A[1] > 0
    prefix = lines[i_0][0 : A[1] - 1]
  endif

  var new_lines_len: number = new_lines->len()

  #echomsg 'i_0 = ' .. i_0 .. ', i_n = ' .. i_n .. ', new_lines = ' .. string(new_lines)
  var n: number = i_n - i_0 + 1
  if n != new_lines_len
    if n > new_lines_len
      # remove the deleted lines
      lines->remove(i_0, i_0 + n - new_lines_len - 1)
    else
      # add empty lines for newly the added lines (will be replaced with the
      # actual lines below)
      lines->extend(repeat([''], new_lines_len - n), i_0)
    endif
  endif
  #echomsg "lines(1) = " .. string(lines)

  # replace the previous lines with the new lines
  for i in new_lines_len->range()
    lines[i_0 + i] = new_lines[i]
  endfor
  #echomsg "lines(2) = " .. string(lines)

  # append the suffix (if any) to the last line
  if suffix != ''
    var i = i_0 + new_lines_len - 1
    lines[i] = lines[i] .. suffix
  endif
  #echomsg "lines(3) = " .. string(lines)

  # prepend the prefix (if any) to the first line
  if prefix != ''
    lines[i_0] = prefix .. lines[i_0]
  endif
  #echomsg "lines(4) = " .. string(lines)

  return lines
enddef

# Apply set of text edits to the specified buffer
# The text edit logic is ported from the Neovim lua implementation
export def ApplyTextEdits(bnr: number, text_edits: list<dict<any>>): void
  if text_edits->empty()
    return
  endif

  # if the buffer is not loaded, load it and make it a listed buffer
  if !bnr->bufloaded()
    bnr->bufload()
  endif
  setbufvar(bnr, '&buflisted', true)

  var start_line: number = 4294967295		# 2 ^ 32
  var finish_line: number = -1
  var updated_edits: list<dict<any>> = []
  var start_row: number
  var start_col: number
  var end_row: number
  var end_col: number

  # create a list of buffer positions where the edits have to be applied.
  for e in text_edits
    # Adjust the start and end columns for multibyte characters
    start_row = e.range.start.line
    start_col = util.GetLineByteFromPos(bnr, e.range.start)
    end_row = e.range.end.line
    end_col = util.GetLineByteFromPos(bnr, e.range.end)
    start_line = [e.range.start.line, start_line]->min()
    finish_line = [e.range.end.line, finish_line]->max()

    updated_edits->add({A: [start_row, start_col],
			B: [end_row, end_col],
			lines: e.newText->split("\n", true)})
  endfor

  # Reverse sort the edit operations by descending line and column numbers so
  # that they can be applied without interfering with each other.
  updated_edits->sort('Edit_sort_func')

  var lines: list<string> = bnr->getbufline(start_line + 1, finish_line + 1)
  var fix_eol: bool = bnr->getbufvar('&fixeol')
  var set_eol = fix_eol && bnr->getbufinfo()[0].linecount <= finish_line + 1
  if set_eol && lines[-1]->len() != 0
    lines->add('')
  endif

  #echomsg 'lines(1) = ' .. string(lines)
  #echomsg updated_edits

  for e in updated_edits
    var A: list<number> = [e.A[0] - start_line, e.A[1]]
    var B: list<number> = [e.B[0] - start_line, e.B[1]]
    lines = Set_lines(lines, A, B, e.lines)
  endfor

  #echomsg 'lines(2) = ' .. string(lines)

  # If the last line is empty and we need to set EOL, then remove it.
  if set_eol && lines[-1]->len() == 0
    lines->remove(-1)
  endif

  #echomsg 'ApplyTextEdits: start_line = ' .. start_line .. ', finish_line = ' .. finish_line
  #echomsg 'lines = ' .. string(lines)

  # Delete all the lines that need to be modified
  bnr->deletebufline(start_line + 1, finish_line + 1)

  # if the buffer is empty, appending lines before the first line adds an
  # extra empty line at the end. Delete the empty line after appending the
  # lines.
  var dellastline: bool = false
  if start_line == 0 && bnr->getbufinfo()[0].linecount == 1 &&
						bnr->getbufline(1)[0] == ''
    dellastline = true
  endif

  # Append the updated lines
  appendbufline(bnr, start_line, lines)

  if dellastline
    bnr->deletebufline(bnr->getbufinfo()[0].linecount)
  endif
enddef

# interface TextDocumentEdit
def ApplyTextDocumentEdit(textDocEdit: dict<any>)
  var bnr: number = bufnr(util.LspUriToFile(textDocEdit.textDocument.uri))
  if bnr == -1
    util.ErrMsg($'Error: Text Document edit, buffer {textDocEdit.textDocument.uri} is not found')
    return
  endif
  ApplyTextEdits(bnr, textDocEdit.edits)
enddef

# interface WorkspaceEdit
export def ApplyWorkspaceEdit(workspaceEdit: dict<any>)
  if workspaceEdit->has_key('documentChanges')
    for change in workspaceEdit.documentChanges
      if change->has_key('kind')
	util.ErrMsg($'Error: Unsupported change in workspace edit [{change.kind}]')
      else
	ApplyTextDocumentEdit(change)
      endif
    endfor
    return
  endif

  if !workspaceEdit->has_key('changes')
    return
  endif

  var save_cursor: list<number> = getcurpos()
  for [uri, changes] in workspaceEdit.changes->items()
    var bnr: number = util.LspUriToBufnr(uri)
    if bnr == 0
      # file is not present
      continue
    endif

    # interface TextEdit
    ApplyTextEdits(bnr, changes)
  endfor
  # Restore the cursor to the location before the edit
  save_cursor->setpos('.')
enddef

# vim: tabstop=8 shiftwidth=2 softtabstop=2
