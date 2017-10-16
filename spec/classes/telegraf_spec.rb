require 'spec_helper'

describe 'chronograf' do
  context 'Supported operating systems' do
    ['RedHat', ].each do |osfamily|
      [6,7].each do |releasenum|
        context "RedHat #{releasenum} release specifics" do
          let(:facts) {{
            :osfamily                  => 'RedHat',
            :architecture              => 'x86_64',
            :kernel                    => 'Linux',
            :operatingsystem           => osfamily,
            :operatingsystemrelease    => releasenum,
            :operatingsystemmajrelease => releasenum,
            :role                      => 'chronograf'
          }}
          it { should compile.with_all_deps }
          it { should contain_class('chronograf::config') }
          it { should contain_class('chronograf::install') }
          it { should contain_class('chronograf::params') }
          it { should contain_class('chronograf::service') }
          it { should contain_class('chronograf')
            .with(
              :ensure         => '1.3.0',
            )
          }
          it { should contain_package('chronograf') }
          it { should contain_service('chronograf') }
          it { should contain_yumrepo('influxdata')
            .with(
              :baseurl => "https://repos.influxdata.com/rhel/#{facts[:operatingsystemmajrelease]}/#{facts[:architecture]}/stable",
            )
          }

          describe 'allow custom repo_type' do
            let(:params) { {:repo_type => 'unstable' } }
            it { should contain_yumrepo('influxdata')
              .with(
                :baseurl => "https://repos.influxdata.com/rhel/#{facts[:operatingsystemmajrelease]}/#{facts[:architecture]}/unstable",
              )
            }
          end
        end
      end
    end
  end
end
