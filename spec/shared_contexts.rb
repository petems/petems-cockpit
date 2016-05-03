require 'hiera-puppet-helper'

# optional, this should be the path to where the hirea data config file is in this repo
hiera_config_file = File.expand_path(File.join(File.dirname(__FILE__), '..','data', 'hiera.yaml'))

# hiera_file and hiera_data are mutally exclusive contexts.

shared_context :hiera do
    # example only,
    let(:hiera_data) do
        {:some_key => "some_value" }
    end
end

shared_context :linux_hiera do
    # example only,
    let(:hiera_data) do
        {:some_key => "some_value" }
    end
end

# In case you want a more specific set of mocked hiera data for windows
shared_context :windows_hiera do
    # example only,
    let(:hiera_data) do
        {:some_key => "some_value" }
    end
end

shared_context :real_hiera_data do
    let(:hiera_config) do
       hirea_config_file
    end
end
