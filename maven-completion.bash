# Maven Autocomplete Script for Bash
# Written by Christopher Maier

# Define Maven's phases
# http://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html#Lifecycle_Reference

# Phases of Maven's "clean" lifecycle
__maven_clean_phases="
	pre-clean
	clean
	post-clean
"

# Phases of Maven's "default" lifecycle
__maven_default_phases="
	validate
	initialize
	generate-sources
	process-sources
	generate-resources
	process-resources
	compile
	process-classes
	generate-test-sources
	process-test-sources
	generate-test-resources
	process-test-resources
	test-compile
	process-test-classes
	test
	prepare-package
	package
	pre-integration-test
	integration-test
	post-integration-test
	verify
	install
	deploy
"

# Phases of Maven's "site" lifecycle
__maven_site_phases="
	pre-site
	site
	post-site
	site-deploy
" 

_maven()
{
    local cur="${COMP_WORDS[COMP_CWORD]}"
	COMPREPLY=( $(compgen -W "${__maven_clean_phases} ${__maven_default_phases} ${__maven_site_phases}" -- ${cur}) )
    return 0
}
complete -F _maven mvn