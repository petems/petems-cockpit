require 'spec_helper'

describe 'cockpit' do
  context 'unsupported operating system' do
    context 'cockpit class without any parameters on Solaris/Nexenta' do
      let :facts do
        {
          os: {
            family: 'Solaris',
            name: 'Nexentana',
          }
        }
      end
    
      it { expect { should contain_package('cockpit') }.to raise_error(Puppet::Error, /Solaris not supported/) }
    end
  end
end
