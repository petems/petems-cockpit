require 'spec_helper'

describe 'cockpit' do
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
