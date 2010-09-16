require File.join(File.dirname(__FILE__), '../spec_helper')

describe FbGraph::Collection, '.new' do
  before(:all) do
    fake_json(:get, 'platform/statuses?access_token=access_token', 'pages/statuses/platform_private')
  end

  it 'should return an array with pagination info' do
    collection = FbGraph::Page.new('platform', :access_token => 'access_token').statuses.collection
    collection.should be_kind_of(Array)
    collection.previous.should be_kind_of(Hash)
    collection.next.should be_kind_of(Hash)
  end

  it 'should allow blank data' do
    patterns = [
      FbGraph::Collection.new,
      FbGraph::Collection.new({}),
      FbGraph::Collection.new({:count => 5}),
      FbGraph::Collection.new(nil)
    ]
    patterns.each do |collection|
      collection.should be_kind_of(Array)
      collection.previous.should be_kind_of(Hash)
      collection.next.should be_kind_of(Hash)
      collection.should be_blank
      collection.previous.should be_blank
      collection.next.should be_blank
    end
  end

  it 'should fetch count as total_count' do
    collection = FbGraph::Collection.new({:count => 5})
    collection.total_count.should == 5
  end
end