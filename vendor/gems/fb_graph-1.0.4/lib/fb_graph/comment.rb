module FbGraph
  class Comment < Node
    attr_accessor :from, :message, :created_time

    def initialize(identifier, attributes = {})
      super
      if (from = attributes[:from])
        @from = if from[:category]
          FbGraph::Page.new(from.delete(:id), from)
        else
          FbGraph::User.new(from.delete(:id), from)
        end
      end
      @message = attributes[:message]
      if attributes[:created_time]
        @created_time = Time.parse(attributes[:created_time]).utc
      end
    end
  end
end