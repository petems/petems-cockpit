require 'spec_helper'

describe 'cockpit' do

  shared_examples 'no parameters' do
    let(:params) {{ }}

    it { should compile.with_all_deps }

    it { should create_class('cockpit') }

    it { should contain_class('cockpit::params') }
    it { should contain_class('cockpit::repo').that_comes_before('cockpit::install') }
    it { should contain_class('cockpit::install').that_comes_before('cockpit::config') }
    it { should contain_class('cockpit::config') }
    it { should contain_class('cockpit::service').that_subscribes_to('cockpit::config') }

    it { should contain_ini_setting('Cockpit LoginTitle').with(
      :ensure    => 'present',
      :path      => '/etc/cockpit/cockpit.conf',
      :section   => 'WebService',
      :setting   => 'LoginTitle',
      :value     => facts[:fqdn],
      :show_diff => true,
      ) }

    it { should contain_service('cockpit').with(
      :ensure => 'running',
      :enable => 'true'
      )}
    it { should contain_package('cockpit').with_ensure('installed') }

    context 'with custom parameters' do
      context 'package name' do
        let(:params) {{ 'package_name' => 'custom-package' }}
        it { should contain_package("#{params['package_name']}") }
      end
      context 'service name' do
        let(:params) {{ 'service_name' => 'custom-service' }}
        it { should contain_service("#{params['service_name']}") }
      end
    end
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :fqdn => 'cockpit.example.com',
        })
      end

      it_behaves_like 'no parameters'
    end
  end

end
