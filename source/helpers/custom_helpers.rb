module CustomHelpers
  def gist(gist_id)

    path = 'source/gists/' + gist_id + '.html'

    ERB.new(File.read(path)).result
  end

  def is_debug_view
    return request['params']['debug']
  end
end