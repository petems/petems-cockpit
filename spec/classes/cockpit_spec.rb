require 'spec_helper'

describe 'cockpit' do

  shared_examples 'no parameters' do
    let(:params) {{ }}

    it { should compile.with_all_deps }

    it { should create_class('cockpit') }

    it { should contain_class('cockpit::params') }
    it { should contain_class('cockpit::repo').that_comes_before('Class[cockpit::install]') }
    it { should contain_class('cockpit::install').that_comes_before('Class[cockpit::config]') }
    it { should contain_class('cockpit::config') }
    it { should contain_class('cockpit::service').that_subscribes_to('Class[cockpit::config]') }

    it { should contain_ini_setting('Cockpit LoginTitle').with(
      :ensure    => 'present',
      :path      => '/etc/cockpit/cockpit.conf',
      :section   => 'WebService',
      :setting   => 'LoginTitle',
      :value     => facts[:fqdn],
      :show_diff => true,
      ) }

    it { should contain_ini_setting('Cockpit LoginTitle').with(
      :ensure    => 'present',
      :path      => '/etc/cockpit/cockpit.conf',
      :section   => 'WebService',
      :setting   => 'LoginTitle',
      :value     => facts[:fqdn],
      :show_diff => true,
      ) }

    it { should contain_ini_setting('Cockpit MaxStartups').with(
      :ensure    => 'present',
      :path      => '/etc/cockpit/cockpit.conf',
      :section   => 'WebService',
      :setting   => 'MaxStartups',
      :value     => '10',
      :show_diff => true,
      ) }

    it { should contain_ini_setting('Cockpit AllowUnencrypted').with(
      :ensure    => 'present',
      :path      => '/etc/cockpit/cockpit.conf',
      :section   => 'WebService',
      :setting   => 'AllowUnencrypted',
      :value     => false,
      :show_diff => true,
      ) }

    it { should contain_service('cockpit').with(
      :ensure => 'running',
      # :enable => 'true'
      )}
    it { should contain_package('cockpit').with_ensure('installed') }

    context 'with custom parameters' do
      context 'package name' do
        let(:params) {{ 'package_name' => 'custom-package' }}
        it { should contain_package("#{params['package_name']}") }
      end
      context 'package version' do
        let(:params) {{ 'package_version' => 'latest' }}
        it { should contain_package('cockpit').with_ensure('latest') }
      end
      context 'manage service' do
        let(:params) {{ 'manage_service' => false }}
        it { should_not contain_service("cockpit") }
      end
      context 'service name' do
        let(:params) {{ 'service_name' => 'custom-service' }}
        it { should contain_service("#{params['service_name']}") }
      end
      context 'port' do
        let(:params) {{ 'port' => '7777' }}
        it {
          should contain_file('/etc/systemd/system/cockpit.socket.d/listen.conf').
            with(:ensure    => 'file')
          should contain_file('/etc/systemd/system/cockpit.socket.d/listen.conf').
            with_content(/ListenStream=7777/)
          should contain_file('/etc/systemd/system/cockpit.socket.d/').
            with(:ensure    => 'directory')
          should contain_exec('Cockpit systemctl daemon-reload').with(
            :command     => 'systemctl daemon-reload',
            :refreshonly => true,
            :path => facts[:path],
          )
        }
      end
    end
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :fqdn => 'cockpit.example.com',
          :path => '/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin:/root/bin'
        })
      end

      it_behaves_like 'no parameters'
    end
  end

end
