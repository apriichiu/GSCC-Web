require File.join(File.dirname(__FILE__), '../../spec_helper')

context 'when included by FbGraph::User' do
  describe FbGraph::Connections::Albums, '#albums' do
    before(:all) do
      fake_json(:get, 'matake/albums', 'users/albums/matake_public')
      fake_json(:get, 'matake/albums?access_token=access_token', 'users/albums/matake_private')
    end

    context 'when no access_token given' do
      it 'should raise FbGraph::Unauthorized' do
        lambda do
          FbGraph::User.new('matake').albums
        end.should raise_exception(FbGraph::Unauthorized)
      end
    end

    context 'when access_token is given' do
      it 'should return albums as FbGraph::Album' do
        albums = FbGraph::User.new('matake', :access_token => 'access_token').albums
        albums.first.should == FbGraph::Album.new(
          '19351532276',
          :access_token => 'access_token',
          :from => {
            :id => '579612276',
            :name => 'Nov Matake'
          },
          :name => 'モバイルアップロード',
          :link => 'http://www.facebook.com/album.php?aid=25463&id=579612276',
          :count => 3,
          :privacy => 'everyone',
          :created_time => '2008-07-27T11:38:15+0000',
          :updated_time => '2009-02-07T16:09:53+0000'
        )
        albums.each do |album|
          album.should be_instance_of(FbGraph::Album)
        end
      end
    end
  end

  describe FbGraph::Connections::Albums, '#album!' do
    before do
      fake_json(:post, 'matake/albums', 'users/albums/post_with_valid_access_token')
    end

    it 'should return generated album' do
      album = FbGraph::User.new('matake', :access_token => 'valid').album!(
        :name => 'FbGraph test',
        :message => 'test test test'
      )
      album.identifier.should == 401096332276
      album.access_token.should == 'valid'
      album.name.should == 'FbGraph test'
      album.description.should == 'test test test'
    end
  end
end