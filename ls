[1mCommand List: 
--[0m
!                 Clear the input buffer. Useful if the parsing process goes wrong and you get stuck in the read loop.
!pry              Start a Pry session on current self; this even works mid multi-line expression.
.<shell command>  All text following a '.' is forwarded to the shell.
amend-line        Amend a line of input in multi-line mode. Type `amend-line --help` for more information. Aliases %
cat               Show output of file FILE. Type `cat --help` for more information.
cd                Move into a new context (use `cd ..` to go back and `cd /` to return to Pry top-level). Complex syntax (e.g cd ../@x/y) also supported.
edit              Invoke the default editor on a file. Type `edit --help` for more info
edit-method       Edit a method. Type `edit-method --help` for more info.
exit              Pop the current binding and return to the one immediately prior. Note this does NOT exit the program. Aliases: quit
exit-all          End the current Pry session (popping all bindings) and returning to caller. Accepts optional return value. Aliases: !!@
exit-program      End the current program. Aliases: quit-program, !!!
gem-cd            Change working directory to specified gem's directory.
gem-install       Install a gem and refresh the gem cache.
gem-list          List/search installed gems. (Optional parameter: a regexp to limit the search)
gist-method       Gist a method to github. Type `gist-method --help` for more info.
help              This menu.
hist              Show and replay Readline history. Type `hist --help` for more info. Aliases: history
import-set        Import a command set
install-command   Install a disabled command.
jump-to           Jump to a binding further up the stack, popping all bindings below.
ls                Show the list of vars and methods in the current scope. Type `ls --help` for more info.
nesting           Show nesting information.
play              Play back a string variable or a method or a file as input. Type `play --help` for more information.
pry-version       Show Pry version.
reload-method     Reload the source file that contains the specified method
req               Require file(s) and expand their paths.
reset             Reset the REPL to a clean state.
ri                View ri documentation. e.g `ri Array#each`
shell-mode        Toggle shell mode. Bring in pwd prompt and file completion.
show-command      Show the source for CMD. Type `show-command --help` for more info.
show-doc          Show the comments above METH. Type `show-doc --help` for more info. Aliases: ?
show-input        Show the contents of the input buffer for the current multi-line expression.
show-method       Show the source for METH. Type `show-method --help` for more info. Aliases: $, show-source
simple-prompt     Toggle the simple prompt.
stat              View method information and set _file_ and _dir_ locals. Type `stat --help` for more info.
switch-to         Start a new sub-session on a binding in the current stack (numbered by nesting).
toggle-color      Toggle syntax highlighting.
whereami          Show the code context for the session. (whereami <n> shows <n> extra lines of code around the invocation line. Default: 5)
