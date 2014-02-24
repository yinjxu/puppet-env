Puppet::Type.type(:env_path).provide(:setx) do
    desc 'Set system envionment variables by setx in windows'

    confine :kernel => :windows

    commands :setx => 'setx'
    commands :reg => 'reg'
    
    def create
        # puts "Create path #{resource[:name]}"
        setx 'PATH', current_path.insert(0,resource[:name].strip).join(';'), '/m'
    end

    def destroy
        # puts "Destroy path #{resource[:name]}"
        a = resource[:name].strip
        setx 'PATH', current_path.delete_if{|b| resource[:ignore_case] == :true ? a.casecmp(b) == 0 : a == b }.join(';'), '/m'
    end

    def exists?
        a = resource[:name].strip
        b = current_path
        # puts "a => #{a}, b => #{b}"
        if resource[:ignore_case] == :true
            a = a.upcase
            b = b.map(&:upcase)
        end
        b.include?(a)
    end
    
    def current_path
        unless @path
            info = reg 'query', 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment', '/v', 'PATH'
            @path = info.strip.split(/\s+/, 5).last.split(';')
        end
        @path
    end
end