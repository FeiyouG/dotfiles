return {
  settings = {
    pylsp = {
      plugins = {
        jedi_completion = {
          enabled = true,
          include_params = true,
          include_class_objects = true,
          include_function_objects = true,
          fuzzy = true,
          eager = false,
          resolve_at_most = 18,
        },
        jedi_definition = {
          enabled = true,
          follow_imports = true,
          follow_builtin_imports = true,
        },
        jedi_hover = { enabled = true },
        jedi_references = { enabled = true },
        jedi_signature_help = { enabled = true },
        jedi_symbols = {
          enabled = true,
          all_scopes = true,
          include_import_symbols = true,
        },

        black = { enabled = true },
        isort = { enabled = true },
        -- rope_autoimport = { enabled = true, memory = false },
        -- rope_completion = { enabled = true, eager = false },
      },
    },
  },
}
