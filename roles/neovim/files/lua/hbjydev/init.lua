local function init()
  require 'hbjydev.vim'.init()
  require 'hbjydev.packer'.init()
end

return {
  init = init
}

