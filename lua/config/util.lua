-- =====================================================================
-- Mappings
-- =====================================================================

function noremap(mode, binding, command)
    vim.keymap.set(mode, binding, command, {noremap = true})
end

function nnoremap(binding, command)
    noremap('n', binding, command)
end

function tnoremap(binding, command)
    noremap('t', binding, command)
end


function multiple_remaps(list, func)
    for k, v in pairs(list) do
        func(k, v)
    end
end

function nnoremaps(list)
    multiple_remaps(list, nnoremap)
end

function tnoremaps(list)
    multiple_remaps(list, tnoremap)
end


function inoremap(binding, command)
    noremap('i', binding, command)
end

function inoremaps(list)
    multiple_remaps(list, tnoremap)
end

-- =====================================================================
-- File stuff
-- =====================================================================
--- Check if a file or directory exists
function exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

--- Check if a directory exists
function isdir(path)
   -- "/" works on both Unix and Windows
   return exists(path.."/")
end

find_buf_by_name = function(name)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name == name then
      return buf
    end
  end
  return -1
end
