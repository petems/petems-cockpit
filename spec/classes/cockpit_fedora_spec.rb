require 'spec_helper'

describe 'cockpit' do
  context 'on Fedora' do
    let(:facts) {{
      :osfamily                  => 'RedHat',
      :operatingsystemmajrelease => '22',
      :operatingsystem           => 'Fedora',
    }}

    context 'repo disabled' do
      let(:params) {{ 'manage_repo' => false }}
      it { should_not contain_yumrepo('extras') }
    end

    context 'repo enabled' do
      let(:params) {{ 'manage_repo' => true }}

      it { should contain_class('cockpit::repo::fedora') }

      it { should contain_yumrepo('updates').with(
        :ensure              => 'present',
        :descr               => 'Fedora $releasever - $basearch - Updates',
        :enabled             => '1',
        :failovermethod      => 'priority',
        :gpgcheck            => '1',
        :gpgkey              => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch',
        :metadata_expire     => '6h',
        :metalink            => 'https://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch',
        :skip_if_unavailable => 'False',
      )}
    end

    context 'with yum_preview_repo => true' do
      let(:params) {{ 'yum_preview_repo' => true }}
      it { should contain_yumrepo('group_cockpit-cockpit-preview').with(
        :descr    => 'Copr repo for cockpit-preview owned by msuchy',
        :enabled  => '1',
        :gpgcheck => '1',
        :gpgkey   => "https://copr-be.cloud.fedoraproject.org/results/@cockpit/cockpit-preview/pubkey.gpg",
        :baseurl  => "https://copr-be.cloud.fedoraproject.org/results/@cockpit/cockpit-preview/fedora-$releasever-$basearch/"
        )}
    end

  end
end
