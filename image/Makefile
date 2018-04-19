REPOSITORY := robobeerun
NAME := wordpress
VERSION ?= v4.9.5-php5.6-fpm-r2

build: _build ##@targets Builds the docker image.

clean: _clean ##@targets Removes the local docker image.

deploy: _deploy ##@targets Deploys the docker image to the repository.

define checkfile_plugin
   $(eval _D=$(firstword $(1) $(@D)))
   cd /tmp && \
   wget -q $(_D) && \
   name=$$(basename $(_D)) && \
   sha=$$(sha256sum $${name}|cut -f1 -d' ') && \
   rm $${name} && \
   echo "RUN set -x \\" && \
   echo "  && /install_wp_plugin.sh $(_D) '$${sha}'"
endef

check-plugins:
	@$(call checkfile_plugin,https://downloads.wordpress.org/plugin/all-in-one-wp-security-and-firewall.zip)
	@$(call checkfile_plugin,https://downloads.wordpress.org/plugin/wp-super-cache.1.5.9.zip)
	@$(call checkfile_plugin,https://downloads.wordpress.org/plugin/wp-piwik.zip)
	@$(call checkfile_plugin,https://downloads.wordpress.org/plugin/contact-form-7.5.0.1.zip)
	@$(call checkfile_plugin,https://downloads.wordpress.org/plugin/black-studio-tinymce-widget.2.6.2.zip)
	@$(call checkfile_plugin,https://downloads.wordpress.org/plugin/wp-optimize.2.2.3.zip)
	@$(call checkfile_plugin,https://downloads.wordpress.org/plugin/the-events-calendar.4.6.14.1.zip)
	@$(call checkfile_plugin,https://downloads.wordpress.org/plugin/broken-link-checker.1.11.5.zip)
	@$(call checkfile_plugin,https://downloads.wordpress.org/plugin/add-to-any.1.7.25.zip)
	@$(call checkfile_plugin,https://downloads.wordpress.org/plugin/cookie-notice.1.2.42.zip)
	@$(call checkfile_plugin,https://downloads.wordpress.org/plugin/akismet.4.0.3.zip)
	@$(call checkfile_plugin,https://downloads.wordpress.org/plugin/favicon-by-realfavicongenerator.zip)
	@$(call checkfile_plugin,https://downloads.wordpress.org/plugin/wp-mail-smtp.zip)

include ../utils/Makefile.help
include ../utils/Makefile.functions
include ../utils/Makefile.image

.PHONY +: build clean deploy
