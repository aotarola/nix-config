let typescript-deno =
      { command = "deno"
      , args = [ "lsp" ]
      , config = { lint = True, enable = True, unstable = True }
      }

in  { typescript-deno }
