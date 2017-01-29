class RequestUtils

  # http://qiita.com/mechamogera/items/9c620155e669b394d513
  def self.get_headers(request)
    http_headers = request.env.select{ |key, _| key.start_with?('HTTP_') }
    headers = http_headers.inject({}) do |ret, (key, value)|
      ret[key.sub(/^HTTP_/, '').downcase.gsub(/(^|_)\w/) { |word| word.upcase }.gsub('_', '-')] = value
      ret
    end
    headers['Content-Type'] = request.content_type
    headers
  end

  def self.get_params(request)
    request.query_parameters
  end
end
