#!/bin/sh
# Import 300 Posts
echo ''
echo '-------------------------------------'
echo 'Importing 300 posts ...'
echo '-------------------------------------'
echo ''
cd source/_posts/
git clone https://github.com/SukkaLab/hexo-5000-posts.git --depth=1
cd ..
cd ..

# Disable fragment cache
echo '-------------------------------------'
echo 'Test performance'
echo '-------------------------------------'
echo ''
echo '-------------------------------------'
echo ' * fragment_fache: off'
echo ' * hexo built in highlight.js: on'
echo ' * suka theme prism highlight: off'
echo ' * suka theme local-search: on'
echo '-------------------------------------'
echo ''
npm run clean > /dev/null
sed -i "s|fragment_cache: true|fragment_cache: false|g" themes/suka/_config.yml
npm run generate > perf.log
cat perf.log | grep 'generated in'

# Enable fragment cache
echo ''
echo '-------------------------------------'
echo ' * fragment_fache: on'
echo ' * hexo built in highlight.js: on'
echo ' * suka theme prism highlight: off'
echo ' * suka theme local-search: on'
echo '-------------------------------------'
echo ''
npm run clean > /dev/null
sed -i "s|fragment_cache: false|fragment_cache: true|g" themes/suka/_config.yml
npm run generate > perf.log
cat perf.log | grep 'generated in'

# Disable Hexo Highlight.js
echo ''
echo '-------------------------------------'
echo ' * fragment_fache: on'
echo ' * hexo built in highlight.js: off'
echo ' * suka theme prism highlight: off'
echo ' * suka theme local-search: on'
echo '-------------------------------------'
echo ''
npm run clean > /dev/null

sed -i '40,44d' _config.yml
echo '
highlight:
  enable: false
  line_number: false
  auto_detect: false
  tab_replace: false' >> _config.yml

npm run generate > perf.log
cat perf.log | grep 'generated in'

# Enable prism highlight
echo ''
echo '-------------------------------------'
echo ' * fragment_fache: on'
echo ' * hexo built in highlight.js: off'
echo ' * suka theme prism highlight: on'
echo ' * suka theme local-search: on'
echo '-------------------------------------'
echo ''
sed -i '64,72d' _config.yml

echo '
suka_theme:
  search:
    enable: true
    path: search.json
    field: post # Page | Post | All. Default post
  prism:
    enable: true
    line_number: true
    theme: ghcolors' >> _config.yml

echo ''
echo '-------------------------------------'
echo ' * fragment_fache: on'
echo ' * hexo built in highlight.js: off'
echo ' * suka theme prism highlight: off'
echo ' * suka theme local-search: off'
echo '-------------------------------------'
echo ''
sed -i '75,83d' _config.yml

echo '
suka_theme:
  search:
    enable: false
    path: search.json
    field: post # Page | Post | All. Default post
  prism:
    enable: false
    line_number: true
    theme: ghcolors' >> _config.yml