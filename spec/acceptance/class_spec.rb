require 'spec_helper_acceptance'

describe 'cockpit class' do

  context 'set show_diff' do
    shell('puppet config set show_diff true', { :acceptable_exit_codes => [0,1] })
  end

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { '::cockpit': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('cockpit') do
      it { is_expected.to be_installed }
    end

    describe service('cockpit') do
      # it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    context 'Cockpit should be running on the default port' do
      describe command('sleep 15 && echo "Give Cockpit time to start"') do
        its(:exit_status) { should eq 0 }
      end

      describe command('curl 0.0.0.0:9090/') do
        its(:stdout) { should match /Cockpit/ }
      end
    end
  end

end
