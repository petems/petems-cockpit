require 'spec_helper_acceptance'

describe 'cockpit class' do

  # The ability to change port is only in more
  # recent versions of Cockpit
  # The one in Fedora (0.67) doesn't have this...
  # So we can only test it with the newer preview versions!
  #

  if fact('operatingsystem') == 'Fedora'
    change_port_pp = <<-EOS
      class { '::cockpit':
        port             => '7777',
        package_version  => latest,
        yum_preview_repo => true,
      }
    EOS
  else
    # Can we get preview PPA for Ubuntu?
    change_port_pp = <<-EOS
      class { '::cockpit':
        port => '7777',
      }
    EOS
  end


  context 'set show_diff' do
    shell('puppet config set show_diff true', { :acceptable_exit_codes => [0,1] })
  end

  context 'different port' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      # Run it twice and test for idempotency

      if fact('operatingsystem') == 'Fedora'
        # HOWEVER you can't upgrade an installed  package with DNF
        # as it's bugged in Puppet: PUP-6324
        #
        # So lets make sure it's removed before we try and install it!
        remove_cockpit_pp = <<-EOS
        class { '::cockpit':
          package_version  => absent,
        }
        EOS
        apply_manifest(remove_cockpit_pp, :catch_failures => true)
      end

      apply_manifest(change_port_pp, :catch_failures => true)
      apply_manifest(change_port_pp, :catch_changes => true)
    end

    describe package('cockpit') do
      it { is_expected.to be_installed }
    end

    describe service('cockpit') do
      # it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    context 'Cockpit should be running on the 7777 port' do
      describe command('sleep 15 && echo "Give Cockpit time to start"') do
        its(:exit_status) { should eq 0 }
      end

      describe command('curl 0.0.0.0:7777/') do
        its(:stdout) { should match /Cockpit/ }
      end
    end
  end

  context 'different port again' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      change_port_again_pp = <<-EOS
      class { '::cockpit':
        port => '7776',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(change_port_again_pp, :catch_failures => true)
      apply_manifest(change_port_again_pp, :catch_changes => true)
    end

    describe package('cockpit') do
      it { is_expected.to be_installed }
    end

    describe service('cockpit') do
      # it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    context 'Cockpit should be running on the 7776 port' do
      describe command('sleep 15 && echo "Give Cockpit time to start"') do
        its(:exit_status) { should eq 0 }
      end

      describe command('curl 0.0.0.0:7776/') do
        its(:stdout) { should match /Cockpit/ }
      end
    end
  end

  context 'using the default port explictly' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      change_port_back_pp = <<-EOS
      class { '::cockpit':
        port => '9090',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(change_port_back_pp, :catch_failures => true)
      apply_manifest(change_port_back_pp, :catch_changes => true)
    end

    describe package('cockpit') do
      it { is_expected.to be_installed }
    end

    describe service('cockpit') do
      # it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    context 'Cockpit should be running on the 9090 port' do
      describe command('sleep 15 && echo "Give Cockpit time to start"') do
        its(:exit_status) { should eq 0 }
      end

      describe command('curl 0.0.0.0:9090/') do
        its(:stdout) { should match /Cockpit/ }
      end
    end
  end
end
