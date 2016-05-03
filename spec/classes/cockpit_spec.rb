require 'spec_helper'

describe 'cockpit' do
  context 'on supported operating systems' do
    context 'without any parameters' do
      let(:params) {{ }}
      let(:facts) {{
        :osfamily                  => 'RedHat',
        :operatingsystemmajrelease => '7',
        :operatingsystem           => 'CentOS',
        :fqdn                      => 'coolserver.vm'
      }}
      it { should compile.with_all_deps }

      it { should create_class('cockpit') }

      it { should contain_class('cockpit::params') }
      it { should contain_class('cockpit::repo').that_comes_before('cockpit::install') }
      it { should contain_class('cockpit::install').that_comes_before('cockpit::config') }
      it { should contain_class('cockpit::config') }
      it { should contain_class('cockpit::service').that_subscribes_to('cockpit::config') }

      it { should contain_class('cockpit::repo::Centos') }

      it { should contain_ini_setting('Cockpit LoginTitle').with(
        :ensure    => 'present',
        :path      => '/etc/cockpit/cockpit.conf',
        :section   => 'WebService',
        :setting   => 'LoginTitle',
        :value     => 'coolserver.vm',
        :show_diff => true,
      ) }

      it { should contain_service('cockpit').with(
        :ensure => 'running',
        :enable => 'true'
      )}
      it { should contain_package('cockpit').with_ensure('installed') }

      it { should contain_yumrepo('extras').with(
        :descr    => 'CentOS-$releasever - Extras',
        :enabled  => '1',
        :gpgcheck => '1',
        :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7",
        :mirrorlist  => "http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra"
      )}

    end
    context 'with custom parameters' do
      let(:facts) {{
        :osfamily                  => 'RedHat',
        :operatingsystemmajrelease => '7',
        :operatingsystem           => 'CentOS',
      }}

      context 'package name' do
        let(:params) {{ 'package_name' => 'custom-package' }}
        it { should contain_package("#{params['package_name']}") }
      end
      context 'service name' do
        let(:params) {{ 'service_name' => 'custom-service' }}
        it { should contain_service("#{params['service_name']}") }
      end
      context 'repo disabled' do
        let(:params) {{ 'manage_repo' => false }}
        it { should_not contain_yumrepo('extras') }
      end

      context 'with yum_preview_repo => true' do
        let(:params) {{ 'yum_preview_repo' => true }}
        it { should contain_yumrepo('group_cockpit-cockpit-preview').with(
          :descr    => 'Copr repo for cockpit-preview owned by msuchy',
          :enabled  => '1',
          :gpgcheck => '1',
          :gpgkey   => "https://copr-be.cloud.fedoraproject.org/results/@cockpit/cockpit-preview/pubkey.gpg",
          :baseurl  => "https://copr-be.cloud.fedoraproject.org/results/@cockpit/cockpit-preview/epel-7-$basearch/"
        )}
      end

    end
  end
  context 'unsupported operating system' do
    context 'cockpit class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('cockpit') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
