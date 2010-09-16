module FbGraph
  class Note < Node
    include Connections::Comments
    include Connections::Likes

    attr_accessor :from, :subject, :message, :created_time, :updated_time, :icon

    def initialize(identifier, attributes = {})
      super
      if (from = attributes[:from])
        @from = if from[:category]
          FbGraph::Page.new(from.delete(:id), from)
        else
          FbGraph::User.new(from.delete(:id), from)
        end
      end
      @subject = attributes[:subject]
      @message = attributes[:message]
      if attributes[:created_time]
        @created_time = Time.parse(attributes[:created_time]).utc
      end
      if attributes[:updated_time]
        @updated_time = Time.parse(attributes[:updated_time]).utc
      end
      @icon = attributes[:icon]
    end
  end
end