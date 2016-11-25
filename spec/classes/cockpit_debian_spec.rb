require 'spec_helper'

describe 'cockpit' do
  context 'on Debian' do
    let(:facts) {{
      :osfamily                  => 'Debian',
      :operatingsystemmajrelease => '8',
      :operatingsystem           => 'Debian',
      :lsbdistid                 => 'Debian',
      :lsbdistcodename           => 'jessie',
      :lsbdistrelease            => '8.0',
      :puppetversion             => Puppet.version,
    }}

    context 'repo disabled' do
      let(:params) {{ 'manage_repo' => false }}
      it { should_not contain_class('cockpit::repo::debian') }
      it { should_not contain_apt__source('cockpit_unstable')}
    end

    context 'repo enabled' do
      let(:params) {{ 'manage_repo' => true }}
      it { should contain_class('cockpit::repo::debian') }
      it { should contain_apt__source('cockpit_unstable')}
    end

  end
end
