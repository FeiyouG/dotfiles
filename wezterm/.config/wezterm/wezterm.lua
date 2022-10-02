local utils = require('utils')
local font = require('font')
local keys = require('keys')
local style = require('style')
local misc = require('misc')

return utils.tbl_merge(
  font,
  keys,
  style,
  misc
)
