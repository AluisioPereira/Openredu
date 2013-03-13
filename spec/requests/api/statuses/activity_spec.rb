require "api_spec_helper"

describe "Activity" do
  let(:current_user) { Factory(:user) }
  let(:token) { _, _, token = generate_token(current_user); token }
  let(:activity) do
    Factory(:activity, :user => current_user, :statusable => current_user)
  end
  let(:params) { { :oauth_token => token, :format => 'json'} }

  before do
    get "/api/statuses/#{activity.id}", params
    @entity = parse(response.body)
  end

  it "should return status 200 (ok)" do
    response.code.should == '200'
  end

  it "should have id, text, created_at, links and type" do
    %w(id text created_at links updated_at type).each do |attr|
      @entity.should have_key attr
    end
  end

  it "should have a link to its Answers" do
    get href_to('answers', @entity), params
    response.code.should == "200"
  end

  it "should have the correct links (statusable, user, self)" do
    %w(statusable self user).each do |attr|
      get href_to(attr, @entity), params
      response.code.should == "200"
    end
  end

  it_should_behave_like "embeds user" do
    let(:embeder) { activity }
    let(:user) { embeder.user }
    let(:entity) { @entity }
  end
end

