require 'spec_helper'

describe 'puppet_masterless' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "puppet_masterless class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('puppet_masterless::params') }
          it { is_expected.to contain_class('puppet_masterless::install').that_comes_before('puppet_masterless::config') }
          it { is_expected.to contain_class('puppet_masterless::config') }
          it { is_expected.to contain_class('puppet_masterless::service').that_subscribes_to('puppet_masterless::config') }

          it { is_expected.to contain_service('puppet_masterless') }
          it { is_expected.to contain_package('puppet_masterless').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'puppet_masterless class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('puppet_masterless') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
