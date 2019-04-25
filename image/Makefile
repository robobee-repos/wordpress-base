REPOSITORY := robobeerun
NAME := wordpress
VERSION ?= v5.1.1-php7.1-fpm-r.2

.PHONY: build
build: _build ##@targets Builds the docker image.

.PHONY: clean
clean: _clean ##@targets Removes the local docker image.

.PHONY: deploy
deploy: _deploy ##@targets Deploys the docker image to the repository.

define checkfile_for_install
   cd /tmp && \
   wget -q $2 && \
   name=$$(basename $2) && \
   sha=$$(sha256sum $${name}|cut -f1 -d' ') && \
   rm $${name} && \
   echo "RUN set -x \\" && \
   echo "  && /install_wp_$1.sh $2 '$${sha}'"
endef

.PHONY: check-plugins
check-plugins: ##@targets Downloads and computes the hash for the specified plugins.
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/add-to-any.1.7.35.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/akismet.4.1.1.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/all-in-one-wp-security-and-firewall.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/atomic-blocks.1.6.1.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/black-studio-tinymce-widget.2.6.8.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/broken-link-checker.1.11.8.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/contact-form-7.5.1.1.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/document-gallery.4.4.3.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/favicon-by-realfavicongenerator.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/gdpr.2.1.0.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/google-analytics-dashboard-for-wp.5.3.7.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/gutenberg.5.5.0.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/iubenda-cookie-law-solution.1.15.7.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/miniorange-login-with-eve-online-google-facebook.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/pdf-image-generator.1.5.6.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/polylang.2.5.3.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/post-smtp.1.9.8.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/responsive-lightbox.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/wp-smushit.3.2.0.1.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/syntaxhighlighter.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/the-events-calendar.4.9.0.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/wp-super-cache.1.6.4.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/wp-optimize.2.3.3.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/wp-typography.5.5.4.zip)

include ../utils/Makefile.help
include ../utils/Makefile.functions
include ../utils/Makefile.image
