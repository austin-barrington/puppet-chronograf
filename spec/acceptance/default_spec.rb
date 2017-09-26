require 'spec_helper_acceptance'

describe 'chronograf' do
  context 'default server' do
      describe package('chronograf') do
        it { should be_installed }
      end
      describe service('chronograf') do
        it { should be_running }
      end
  end
end
