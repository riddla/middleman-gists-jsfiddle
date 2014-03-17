###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }
modules = Dir['source/gists/*']
puts modules.inspect

modules.map! do |gists_name|
  gists_name = File.basename(gists_name).gsub(/^[_]+/, '').gsub(/.erb$/, '')
  puts gists_name
  proxy "/gists/#{gists_name}/", "/index.html", :locals => { :gist_id => gists_name }
end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

helpers do
  def gist(gist_id)

    path = 'source/gists/' + gist_id + '/fiddle.html'

    ERB.new(File.read(path)).result
  end

  def gist_is_synchronized(gist_id)

    path = 'source/gists/' + gist_id + '/'
    result = %x{cd #{path}; git status}

    result = %x{cd #{path}; [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "nope!"}

  end

  def is_debug_view
    return request['params']['debug']
  end
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
