Puppet.newtype(:env_path) do
    desc 'Manage system path variable'

    ensurable

    newparam(:name, :namevar => true) do
        desc 'System path value'
    end
    
    newparam(:ignore_case) do
        desc 'Whether ignore case of path value'
        newvalues :true, :false
        defaultto :false
    end
    
    # TODO: Support system/local environment option, with "/m"
end