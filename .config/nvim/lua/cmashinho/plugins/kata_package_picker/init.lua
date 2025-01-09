local M = {}

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local job = require "plenary.job"
local conf = require("telescope.config").values
local Path = require "plenary.path"

CACHED_DATA = {}
KATA_FILENAME = ".kata_nvim_folders"

local function read_content_from_disk()
  local uv = vim.uv or vim.loop
  local kata_file = Path:new(vim.fs.joinpath(uv.os_homedir(), KATA_FILENAME))
  local decoded_content = nil

  if kata_file:exists() then
    local content = kata_file:read()
    if content ~= "" then
      decoded_content = vim.json.decode(content)
    end
  end

  return decoded_content
end

local function dump_content_to_disk(content)
  local uv = vim.uv or vim.loop
  local kata_file = Path:new(vim.fs.joinpath(uv.os_homedir(), KATA_FILENAME))
  kata_file:write(vim.json.encode(content), "w")
end

local function join_strings(strings)
  local string = ""
  for _, x in ipairs(strings) do
    string = string .. x
  end
  return string
end

local function create_call_kata_python_bootstrap_job(on_exit)
  return job:new {
    command = "kata-python-bootstrap",
    args = { "list-packages", "--json" },
    on_exit = on_exit,
  }
end

local function handle_raw_kata_python_bootstrap_output(content)
  local processed_content = {}
  for index in pairs(content) do
    table.insert(processed_content, {
      content[index]["name"],
      content[index]["root_dir"] .. "/source",
    })
  end
  return processed_content
end

local function get_kata_python_bootstrap_output(on_exit, async)
  local function process_output(j, _, _)
    local result = handle_raw_kata_python_bootstrap_output(vim.json.decode(join_strings(j:result())))
    if on_exit ~= nil then
      on_exit(result)
    else
      return result
    end
  end

  if async == true then
    create_call_kata_python_bootstrap_job(process_output):start()
  else
    create_call_kata_python_bootstrap_job(process_output):sync()
  end
end

local function setup()
  local content_from_disk = read_content_from_disk()

  local function on_exit(output)
    if #CACHED_DATA ~= #output then
      dump_content_to_disk(output)
      CACHED_DATA = output
      return
    end
  end

  if content_from_disk ~= nil then
    CACHED_DATA = content_from_disk
    get_kata_python_bootstrap_output(on_exit, true)
  else
    get_kata_python_bootstrap_output(on_exit, false)
  end
end

local function get_files()
  function string:split(delimiter)
    local result = {}
    local from = 1
    local delim_from, delim_to = string.find(self, delimiter, from, true)
    while delim_from do
      if delim_from ~= 1 then
        table.insert(result, string.sub(self, from, delim_from - 1))
      end
      from = delim_to + 1
      delim_from, delim_to = string.find(self, delimiter, from, true)
    end
    if from <= #self then
      table.insert(result, string.sub(self, from))
    end
    return result
  end

  if next(CACHED_DATA) == nil then
    setup():sync()
  end

  return CACHED_DATA
end

local function search_root(buf_name)
  if buf_name == nil then
    return nil, nil
  end
  for i in pairs(CACHED_DATA) do
    local pkg_root_path = CACHED_DATA[i][2]
    if string.sub(buf_name, 1, string.len(pkg_root_path)) == pkg_root_path then
      return CACHED_DATA[i][1], pkg_root_path
    end
  end
  return nil, nil
end

local function get_all_python_sources()
  local custom_paths = {}
  for index in pairs(CACHED_DATA) do
    table.insert(custom_paths, CACHED_DATA[index][2])
  end
  return custom_paths
end

M.picker = function()
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "Select KATA package",
      finder = finders.new_table {
        results = get_files(),
        entry_maker = function(entry)
          return {
            value = entry[2],
            display = entry[1],
            ordinal = entry[1],
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
    })
    :find()
end

M.search_root = function(buf_name)
  return search_root(buf_name)
end

M.setup = function()
  pcall(setup)
end

M.get_all_python_sources = function()
  return get_all_python_sources()
end

return M
