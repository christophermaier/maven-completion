# Maven Autocomplete Script for Bash
# Written by Christopher Maier

# Define Maven's phases
# http://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html#Lifecycle_Reference

# Phases of Maven's "clean" lifecycle
__maven_clean_phases='pre-clean :clean :post-clean '

# Phases of Maven's "default" lifecycle
__maven_default_phases="validate :initialize :generate-sources :process-sources :generate-resources :process-resources :compile :process-classes :generate-test-sources :process-test-sources :generate-test-resources :process-test-resources :test-compile :process-test-classes :test :prepare-package :package :pre-integration-test :integration-test :post-integration-test :verify :install :deploy "

# Phases of Maven's "site" lifecycle
__maven_site_phases="pre-site :site :post-site :site-deploy "

# Maven's GNU-style option flags
_maven_double_dash_options="--also-make :--also-make-dependents :--batch-mode :--strict-checksums :--lax-checksums :--check-plugin-updates :--define :--errors :--encrypt-master-password :--encrypt-password :--file :--fail-at-end :--fail-fast :--fail-never :--global-settings :--help :--non-recursive :--no-plugin-registry :--no-plugin-updates :--offline :--activate-profiles :--projects :--quiet :--reactor :--resume-from :--settings :--update-snapshots :--update-plugins :--show-version :--version :--debug"

# Maven's simple option flags
__maven_single_dash_options="-am :-amd :-B :-C :-c :-cpu :-D :-e :-emp :-ep :-f :-fae :-ff :-fn :-gs :-h :-N :-npr :-npu :-o :-P :-pl :-q :-r :-rf :-s :-U :-up :-V :-v :-X "

# Use xsltproc to extract property names (defined in a <properties> node) from a Maven POM
# This will only work if xsltproc is on the path
__maven_properties_from_pom(){
if (type -P xsltproc &>/dev/null)
then
( xsltproc - $1 ) << EOF
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:m="http://maven.apache.org/POM/4.0.0">
    <xsl:output method="text"/>
    <xsl:template match="/">
        <xsl:for-each select="m:project/m:properties/*">
            <xsl:value-of select="local-name()"/><xsl:text> </xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
EOF
fi
}

# Collect the properties from this pom and all parent poms above it in the filesystem
# It doesn't fetch parent poms that aren't in the file hierarchy, though
__maven_properties(){
    local directory=${PWD}
    local props
    if [ -e "pom.xml" ]
    then
        props="$@ $(__maven_properties_from_pom pom.xml)"
        cd .. && __maven_properties $props
    fi
    cd $directory

    echo "$props"
}

_maven(){
    local cur
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"

    case $cur in
        -D*)
            # For the purposes of making a match, remove '-D' from the beginning
            # Then, for the purposes of creating the suggestions, add the '-D' back to the beginning, and tack an '=' on to the end
            COMPREPLY=( $(compgen -P'-D' -S= -W "$(__maven_properties)" -- ${cur#-D}) )
            ;;
        *)
            # Make sure to break on the ':' character in order to get the manually-added spaces
            # TODO: let's do this programmatically, instead of having to add them all manually, use a weird delimiter, etc.
            local IFS=$':\t\n'
            COMPREPLY=( $(compgen -W "${__maven_clean_phases}:${__maven_default_phases}:${__maven_site_phases}:${__maven_single_dash_options}:${__maven_double_dash_options}" -- ${cur}) )
        ;;
    esac
    return 0
}

complete -o nospace -F _maven mvn