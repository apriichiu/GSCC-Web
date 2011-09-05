require 'spec_helper'

describe FbGraph::Connections::Comments, '#comments' do
  context 'when included by FbGraph::Post' do
    let :post do
      mock_graph :get, 'no_comments', 'posts/no_comments' do
        FbGraph::Post.new('no_comments').fetch
      end
    end

    it 'should use cached @_comments_ as default' do
      lambda do
        post.comments
      end.should_not request_to "#{post.identifier}/comments"
    end

    it 'should ignore cached @_comments_ when options are given' do
      lambda do
        post.comments(:no_cache => true)
      end.should request_to "#{post.identifier}/comments"
    end
  end
end

describe FbGraph::Connections::Comments, '#comment!' do
  context 'when included by FbGraph::Post' do
    context 'when no access_token given' do
      it 'should raise FbGraph::Exception' do
        mock_graph :post, '12345/comments', 'posts/comments/post_without_access_token', :status => [500, 'Internal Server Error'] do
          lambda do
            FbGraph::Post.new('12345').comment!(:message => 'hello')
          end.should raise_exception(FbGraph::Exception)
        end
      end
    end

    context 'when invalid access_token is given' do
      it 'should raise FbGraph::Exception' do
        mock_graph :post, '12345/comments', 'posts/comments/post_with_invalid_access_token', :status => [500, 'Internal Server Error'] do
          lambda do
            FbGraph::Post.new('12345', :access_token => 'invalid').comment!(:message => 'hello')
          end.should raise_exception(FbGraph::Exception)
        end
      end
    end

    context 'when valid access_token is given' do
      before do
        
      end

      it 'should return generated comment' do
        mock_graph :post, '12345/comments', 'posts/comments/post_with_valid_access_token' do
          comment = FbGraph::Post.new('12345', :access_token => 'valid').comment!(:message => 'hello')
          comment.identifier.should == '117513961602338_119401698085884_535271'
          comment.access_token.should == 'valid'
          comment.message.should == 'hello'
          comment.access_token.should == 'valid'
        end
      end
    end
  end
end

describe FbGraph::Connections::Comments, '#like!' do
  context 'when included by FbGraph::Post' do
    context 'when no access_token given' do
      it 'should raise FbGraph::Exception' do
        mock_graph :post, '12345/likes', 'posts/likes/post_without_access_token', :status => [500, 'Internal Server Error'] do
          lambda do
            FbGraph::Post.new('12345').like!
          end.should raise_exception(FbGraph::Exception)
        end
      end
    end

    context 'when invalid access_token is given' do
      it 'should raise FbGraph::Exception' do
        mock_graph :post, '12345/likes', 'posts/likes/post_with_invalid_access_token', :status => [500, 'Internal Server Error'] do
          lambda do
            FbGraph::Post.new('12345', :access_token => 'invalid').like!
          end.should raise_exception(FbGraph::Exception)
        end
      end
    end

    context 'when valid access_token is given' do
      it 'should return true' do
        mock_graph :post, '12345/likes', 'posts/likes/post_with_valid_access_token' do
          FbGraph::Post.new('12345', :access_token => 'valid').like!.should be_true
        end
      end
    end
  end
end

describe FbGraph::Connections::Comments, '#unlike!' do
  it 'should DELETE /:object_id/likes' do
    mock_graph :delete, '12345/likes', 'true', :access_token => 'valid' do
      FbGraph::Post.new('12345', :access_token => 'valid').unlike!
    end
  end
end