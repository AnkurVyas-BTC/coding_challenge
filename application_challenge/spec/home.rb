require File.expand_path '../spec_helper.rb', __FILE__

describe 'My Sinatra Application' do
  it 'should allow accessing the home page' do
    expect_any_instance_of(RSpec::ExampleGroups::MySinatraApplication).to receive(:api_response)
    expect_any_instance_of(RSpec::ExampleGroups::MySinatraApplication).to receive(:save_to_database)

    call
  end
end