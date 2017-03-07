require 'spec_helper'

describe 'cockpit' do
  context 'on Ubuntu' do
    let(:facts) {{
      :osfamily                  => 'Debian',
      :operatingsystemmajrelease => '16.04',
      :operatingsystem           => 'Ubuntu',
      :lsbdistid                 => 'Ubuntu',
      :lsbdistcodename           => 'xenial',
      :lsbdistrelease            => '16.04',
      :puppetversion             => Puppet.version
    }}

    context 'repo disabled' do
      let(:params) {{ 'manage_repo' => false }}
      it { should_not contain_class('cockpit::repo::ubuntu')}
      it { should_not contain_apt__ppa('ppa:cockpit-project/cockpit')}
    end

    context 'repo enabled' do
      let(:params) {{ 'manage_repo' => true }}
      it { should contain_class('cockpit::repo::ubuntu')}
      it {
          is_expected.to contain_apt__source('cockpit').with(
            :ensure    => 'present',
            :location  => 'http://ppa.launchpad.net/cockpit-project/cockpit/ubuntu',
            :release   => 'xenial',
            :repos     => 'main',
            :key       => {
              "id"=>"637A2C82EDB1EF02DA658EE1046452EBC99782CC",
              "server"=>"keyserver.ubuntu.com"
            }
          )
        }
    end

  end
end
