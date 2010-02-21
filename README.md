maven-completion
================

`maven-completion.bash` is a Bash completion script for the [Maven](http://maven.apache.org) Java build manager.  It was inspired by the [Git completion script](http://repo.or.cz/w/git.git/blob_plain/1958e5be90be7bba3037b8a7853f0fb64f24fc09:/contrib/completion/git-completion.bash), as well as the completion scripts that are part of the [bash-completion](http://bash-completion.alioth.debian.org/) project, though it does not (currently) depend on that project for any functionality.

Installation
------------

Save this script somewhere and load it up in your `~/.profile` or other appropriate shell startup file:

	. ~/.maven-completion.bash

Alternatively, if you have `bash-completion` installed and configured, you could drop the file system-wide completion scripts directory and it will get loaded for you automatically.  I put mine in a personal directory, set up like this in my `~/.profile`:

    export BASH_COMPLETION_DIR=~/.bash_completion.d
    if [ -f /opt/local/etc/bash_completion ]; then
        . /opt/local/etc/bash_completion
    fi
( I'm on Mac OS X, with `bash-completion` installed via [MacPorts](http://trac.macports.org/wiki/howto/bash-completion). )  Again, this project does not currently depend on `bash-completion` at all, but if you've already got it installed, it allows you to start using it with a minimum of fuss.

How to Use
----------

The script is currently very basic, providing completion for all Maven lifecycle phases, as well as command-line flags (both short and long style).  Future plans include support for completing properties, module names, and even some commonly-used plugin goals (such as the ones from the [maven-help-plugin](http://maven.apache.org/plugins/maven-help-plugin/)).

Just start typing a command and hit <TAB><TAB> to show options for completion:

    $ mvn --<TAB><TAB>
    --activate-profiles        --define                   --fail-never               --no-plugin-updates        --resume-from              --version
    --also-make                --encrypt-master-password  --file                     --non-recursive            --settings
    --also-make-dependents     --encrypt-password         --global-settings          --offline                  --show-version
    --batch-mode               --errors                   --help                     --projects                 --strict-checksums
    --check-plugin-updates     --fail-at-end              --lax-checksums            --quiet                    --update-plugins
    --debug                    --fail-fast                --no-plugin-registry       --reactor                  --update-snapshots
    $ mvn --fail-<TAB><TAB>
    --fail-at-end  --fail-fast    --fail-never
    $ mvn process-<TAB><TAB>
    process-classes         process-resources       process-sources         process-test-classes    process-test-resources  process-test-sources

Just keep typing to narrow down your options.  When there is only one choice left, the script will complete the rest of the word for you.