module FbGraph
  class Album < Node
    include Connections::Photos
    include Connections::Comments
    include Connections::Likes
    include Connections::Picture

    attr_accessor :from, :name, :description, :location, :link, :cover_photo, :privacy, :count, :type, :created_time, :updated_time

    def initialize(identifier, attributes = {})
      super
      @from = if (from = attributes[:from])
        if from[:category]
          Page.new(from[:id], from)
        else
          User.new(from[:id], from)
        end
      end
      @name = attributes[:name]
      # NOTE:
      # for some reason, facebook uses different parameter names.
      # "description" in GET & "message" in POST
      @description = attributes[:description] || attributes[:message]
      @location    = attributes[:location]
      @link        = attributes[:link]
      @privacy     = attributes[:privacy]
      @count       = attributes[:count]
      @type        = attributes[:type]

      @cover_photo = if attributes[:cover_photo]
        Photo.new(attributes[:cover_photo])
      end
      @created_time = if attributes[:created_time]
        Time.parse(attributes[:created_time]).utc
      end
      @updated_time = if attributes[:updated_time]
        Time.parse(attributes[:updated_time]).utc
      end

      # cached connection
      @_comments_ = Collection.new(attributes[:comments])
    end

    def picture_with_access_token(size = nil)
      raise Unauthorized.new('Album picture connection requires an access token') unless self.access_token
      _endpoint_ = URI.parse picture_without_access_token(size)
      _endpoint_.query = [_endpoint_.query, {:access_token => self.access_token.to_s}.to_query].compact.join('&')
      _endpoint_.to_s
    end
    alias_method_chain :picture, :access_token
  end
end