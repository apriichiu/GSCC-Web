require File.join(File.dirname(__FILE__), '../../spec_helper')

describe FbGraph::Connections::Groups, '#groups' do
  context 'when included by FbGraph::User' do
    before(:all) do
      fake_json(:get, 'matake/groups', 'users/groups/matake_public')
      fake_json(:get, 'matake/groups?access_token=access_token', 'users/groups/matake_private')
    end

    context 'when no access_token given' do
      it 'should raise FbGraph::Unauthorized' do
        lambda do
          FbGraph::User.new('matake').groups
        end.should raise_exception(FbGraph::Unauthorized)
      end
    end

    context 'when access_token is given' do
      it 'should return groups as FbGraph::Group' do
        groups = FbGraph::User.new('matake', :access_token => 'access_token').groups
        groups.first.should == FbGraph::Group.new(
          '115286585902',
          :access_token => 'access_token',
          :name => 'iPhone 3G S'
        )
        groups.each do |group|
          group.should be_instance_of(FbGraph::Group)
        end
      end
    end
  end
end