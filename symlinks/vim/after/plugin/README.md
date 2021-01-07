## Plugin overrides

This directory should mostly be used to configure specific plugins, by running after them.
In some cases it may be required to run some code before plugin, in which case /plugin dir can be used.
Other than this, custom plugins should be located in /plugin dir, unless plugin explicitly overrides some other plugin, in which case, it would probably be better to either disable other plugin or just override it with that plugin specific file.
