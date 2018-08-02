#!/bin/bash
set -e

plugins_urls=(
https://downloads.wordpress.org/plugin/add-to-any.1.7.28.zip
https://downloads.wordpress.org/plugin/akismet.4.0.8.zip
https://downloads.wordpress.org/plugin/all-in-one-wp-security-and-firewall.zip
https://downloads.wordpress.org/plugin/black-studio-tinymce-widget.2.6.2.zip
https://downloads.wordpress.org/plugin/broken-link-checker.1.11.5.zip
https://downloads.wordpress.org/plugin/contact-form-7.5.0.3.zip
https://downloads.wordpress.org/plugin/cookie-notice.1.2.44.zip
https://downloads.wordpress.org/plugin/favicon-by-realfavicongenerator.zip
https://downloads.wordpress.org/plugin/google-analytics-dashboard-for-wp.5.3.5.zip
https://downloads.wordpress.org/plugin/post-smtp.zip
https://downloads.wordpress.org/plugin/the-events-calendar.4.6.21.zip
https://downloads.wordpress.org/plugin/wp-smushit.2.8.0.zip
https://downloads.wordpress.org/plugin/wp-super-cache.1.6.2.zip
https://downloads.wordpress.org/plugin/wp-optimize.2.2.4.zip
)

cd ..
mkdir -p downloads
cd downloads
set +e && rm plugins_dockerfile.txt

for url in ${plugins_urls[@]}; do
  file=$(basename $url)
  redownload=1
  if ! echo $url | grep -P "\\w+(\\.\\d+)+\\.zip">/dev/null; then
    redownload=0
  fi
  if [[ $redownload -eq 0 ]] || [[ ! -f "${file}" ]]; then
    rm ${file}
    wget $url
  fi
  sha=$(sha256sum ${file} | cut -d' ' -f1)
  echo "RUN set -x \\" >> plugins_dockerfile.txt
  echo "  && /install_wp_plugin.sh ${url} '${sha}'" >> plugins_dockerfile.txt
  echo "" >> plugins_dockerfile.txt
done

cat plugins_dockerfile.txt
