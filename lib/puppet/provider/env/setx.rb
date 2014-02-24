Puppet::Type.type(:env).provide(:setx) do
    desc 'Set system envionment variables by setx in windows'

    confine :kernel => :windows
    
    commands :setx => 'setx'
    commands :reg => 'reg'

    def create
        # puts "Create variable #{resource[:name]} => #{resource[:value]}"
        setx resource[:name], resource[:value].strip, '/m'
    end

    def destroy
        # puts "Destroy path #{resource[:name]}"
        reg 'delete', 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
            '/v', resource[:name],  '/f'
    end

    def exists?
        begin
            info = reg 'query', 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment', '/v', resource[:name]
            b = info.strip.split(/\s+/, 5).last
            if resource.property(:ensure).value == :absent
                true
            else
                a = resource[:value].strip
                # puts "a => #{a}, b => #{b}"
                resource[:ignore_case] == :true ? a.casecmp(b) == 0 : a == b
            end
        rescue Puppet::ExecutionFailure => e
            if e.to_s.include? 'The system was unable to find the specified registry key or value'
                false
            else
                raise e
            end
        end
    end
end