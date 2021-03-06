function vec_apc_arp_upright = snr_setup_ant_offset_eval (data, ...
antenna, radome, freq_name)
    %if strcmpi(antenna, 'isotropic')  % WRONG!
    if strncmpi(antenna, 'isotropic', numel('isotropic'))
        vec_apc_arp_upright = [0 0 0];
        return;
    end
    idx = strcmpi(data.antenna,   antenna) ...
        & strcmpi(data.radome,    radome) ...
        & strcmpi(data.freq_name, freq_name);
    switch sum(idx)
    case 0
        if strstarti('R', freq_name)
            freq_name2 = setel(freq_name, 1, 'L');
            idx = strcmpi(data.antenna,   antenna) ...
                & strcmpi(data.radome,    radome) ...
                & strcmpi(data.freq_name, freq_name2);
            % (disabled warning because normally GLO offsets are identical to GPS.)
            %warning('snr:antOffset:noData', ...
            %    ['ARP-APC offset unavailable for frequency "%s"; trying "%s" '...
            %    '(model "%s" and radome "%s").'], ...
            %    freq_name, freq_name2, antenna, radome);
            vec_apc_arp_upright = [data.north(idx), data.east(idx), data.up(idx)];
        else
            warning('snr:antOffset:combUnknown', ...
                ['ARP-APC offset unknown; assuming zero \n'...
                '(model "%s" and radome "%s" in "%s" frequency).\n'...
                'To enter this information, please ' ...
                '<a href="matlab:edit(''%s'');">click here</a>;\n' ...
                'to disable this warning message, ' ...
                '<a href="matlab:warning(''off'', ''snr:antOffset:combUnknown'');">'...
                'click here instead</a>.' ...
                ], antenna, radome, freq_name, data.filepath);
            vec_apc_arp_upright = [0 0 0];       
        end
    case 1
        vec_apc_arp_upright = [data.north(idx), data.east(idx), data.up(idx)];
        %vec_apc_arp_upright = vec_apc_arp_upright ./ 1e3;  % from mm to meters.
        % WRONG! conversion from mm to m was already done in snr_load_antenna_offset/snr_load_antenna_offset_aux.
    otherwise
        error('snr:antOffset:stationAntenna', ...
           'Multiple records for ARP-APC offset for antenna model "%s" and radome "%s" in %s frequency.', ...
           antenna, radome, freq_name);
    end
end
