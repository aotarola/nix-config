let dockerfile =
      { command = "docker-langserver"
      , args = [ "--stdio" ]
      , config.docker.languageserver.formatter.ignoreMultilineInstructions
        = False
      }

in  { dockerfile }
