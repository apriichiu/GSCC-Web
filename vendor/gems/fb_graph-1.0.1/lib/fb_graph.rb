require 'rubygems'
require 'json'
require 'restclient'
require 'oauth2'

# NOTE:
# For some reason, ActiveSupport 3.0.0 doesn'tj load whole code.
# Load needed extention directly for now.
require 'active_support/core_ext'

module FbGraph
  ROOT_URL = "https://graph.facebook.com"

  class Exception < StandardError
    attr_accessor :code, :type, :message
    def initialize(code, message, body = '')
      @code = code
      if body.blank?
        @message = message
      else
        response = JSON.parse(body).with_indifferent_access
        @message = response[:error][:message]
        @type = response[:error][:type]
      end
    end
  end

  class BadRequest < FbGraph::Exception
    def initialize(message, body = '')
      super 400, message, body
    end
  end

  class Unauthorized < FbGraph::Exception
    def initialize(message, body = '')
      super 401, message, body
    end
  end

  class NotFound < FbGraph::Exception
    def initialize(message, body = '')
      super 404, message, body
    end
  end

end

require 'fb_graph/auth'
require 'fb_graph/comparison'
require 'fb_graph/collection'
require 'fb_graph/connection'
require 'fb_graph/connections'
require 'fb_graph/searchable'

require 'fb_graph/node'
require 'fb_graph/album'
require 'fb_graph/application'
require 'fb_graph/checkin'
require 'fb_graph/comment'
require 'fb_graph/education'
require 'fb_graph/event'
require 'fb_graph/group'
require 'fb_graph/insight'
require 'fb_graph/link'
require 'fb_graph/note'
require 'fb_graph/page'
require 'fb_graph/photo'
require 'fb_graph/post'
require 'fb_graph/status'
require 'fb_graph/subscription'
require 'fb_graph/tag'
require 'fb_graph/user'
require 'fb_graph/venue'
require 'fb_graph/video'
require 'fb_graph/work'