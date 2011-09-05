require 'spec_helper'

describe FbGraph::Connections::Inbox, '#inbox' do
  # NOTE:
  #  This connection returns Post instead of Thread for now.
  #  See inbox.rb for more details.
  it 'should return threads as FbGraph::Post' do
    mock_graph :get, 'me/inbox', 'users/inbox/me_private', :access_token => 'access_token' do
      threads = FbGraph::User.me('access_token').inbox
      threads.each do |thread|
        thread.should be_instance_of(FbGraph::Post)
      end
    end
  end
end