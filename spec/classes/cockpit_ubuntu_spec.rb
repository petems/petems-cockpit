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
      it { should contain_apt__ppa('ppa:cockpit-project/cockpit')}
    end

  end
end
