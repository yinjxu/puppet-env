Puppet.newtype(:env) do
    desc 'Manage system envionment variables'

    ensurable

    newparam(:name, :namevar => true) do
        desc 'Envionment variable name'
    end

    newparam(:value) do
        desc 'Envionment variable value'
    end
    
    newparam(:ignore_case) do
        desc 'Whether ignore case of envionment variable value'
        newvalues :true, :false
        defaultto :false
    end 
    
    # TODO: Support system/local environment option, with "/m"
end