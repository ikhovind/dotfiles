require('leap').add_repeat_mappings(';', ',', {
  -- False by default. If set to true, the keys will work like the
  -- native semicolon/comma, i.e., forward/backward is understood in
  -- relation to the last motion.
  relative_directions = true,
  -- By default, all modes are included.
  modes = {'n', 'x', 'o'},
})
require('leap').add_default_mappings()

return {}
