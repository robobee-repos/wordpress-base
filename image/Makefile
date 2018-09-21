REPOSITORY := robobeerun
NAME := wordpress
VERSION ?= 4.9.8-php7.1-fpm-r.1

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
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/add-to-any.1.7.30.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/akismet.4.0.8.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/all-in-one-wp-security-and-firewall.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/atomic-blocks.1.3.4.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/black-studio-tinymce-widget.2.6.2.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/broken-link-checker.1.11.5.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/contact-form-7.5.0.4.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/document-gallery.4.4.3.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/favicon-by-realfavicongenerator.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/gdpr.2.1.0.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/google-analytics-dashboard-for-wp.5.3.5.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/gutenberg.3.8.0.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/iubenda-cookie-law-solution.1.15.1.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/miniorange-login-with-eve-online-google-facebook.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/pdf-image-generator.1.5.6.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/polylang.2.3.10.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/post-smtp.1.9.4.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/responsive-lightbox.2.0.5.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/wp-smushit.2.8.1.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/syntaxhighlighter.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/the-events-calendar.4.6.23.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/wp-super-cache.1.6.4.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/wp-optimize.2.2.4.zip)
	@$(call checkfile_for_install,plugin,https://downloads.wordpress.org/plugin/wp-typography.5.4.1.zip)

include ../utils/Makefile.help
include ../utils/Makefile.functions
include ../utils/Makefile.image
