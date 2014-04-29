require 'spec_helper'

describe ApiKey do
  subject { Fabricate(:api_key) }

  context 'with a valid api key' do
    its( :token ) { should_not be_blank }
    it { expect(subject).should be_valid }
  end

  context 'with an invalid api key' do
    let(:invalid_api_key) { Fabricate.build(:api_key, token: subject.token) }

    it { expect(invalid_api_key).to be_invalid }
  end

end
