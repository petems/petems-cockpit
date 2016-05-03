require 'spec_helper'

describe 'cockpit' do
  context 'on CentOS' do
    let(:facts) {{
      :osfamily                  => 'RedHat',
      :operatingsystemmajrelease => '7',
      :operatingsystem           => 'CentOS',
    }}

    context 'repo disabled' do
      let(:params) {{ 'manage_repo' => false }}
      it { should_not contain_yumrepo('extras') }
    end

    context 'repo enabled' do
      let(:params) {{ 'manage_repo' => true }}
      it { should contain_yumrepo('extras').with(
        :descr    => 'CentOS-$releasever - Extras',
        :enabled  => '1',
        :gpgcheck => '1',
        :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7",
        :mirrorlist  => "http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra"
      )}
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
