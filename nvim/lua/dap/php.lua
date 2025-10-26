return {
  adapters = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" },
  },

  configurations = {
    {
      name = "Listen for Xdebug",
      type = "php",
      request = "launch",
      port = "9003",
    },
    {
      name = "Listen for Address",
      type = "php",
      request = "launch",
      port = "9003",
      pathMappings = {
        ["/var/www/html"] = "${workspaceFolder}",
      },
    },
  },
}
