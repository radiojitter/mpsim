function snr_ant_plot (data, dir)
if (nargin < 2),  dir = [];  end
if ~isempty(dir) && ~ischar(dir)
    warning('snr:antenna_gain_plot:bad2ndArg', ...
        'Second input argument must be of type "char"; ignoring it');
    dir = [];
end

for i=1:2
switch i
case 1
    tempa = (data.profile.original + data.profile.offset);
    tit = sprintf('Offset %s (%s)\n%s', ...
        lower(data.profile.original_label), data.profile.original_units, data.filename);
    filename = [data.filename '-' data.profile.original_units '-offset-prof.png'];
case 2
    tempa = (data.profile.original);
    tit = sprintf('%s (%s)\n%s', ...
        data.profile.original_label, data.profile.original_units, data.filename);
    filename = [data.filename '-' data.profile.original_units '-prof.png'];
end
tempb = max(-tempa);
tempb = ceil(tempb/10)*10;
temp = tempa + tempb;
temp1 = max(temp);
temp2 = min(temp);
temp1 =  ceil(temp1/10)*10;
temp2 = floor(temp2/10)*10;
temp5 = 10;
if (((temp1 - temp2) / temp5) < 3),  temp5 = 5;  end
temp3 = (temp1:-temp5:temp2) - tempb;
temp4 = arrayfun(@(x) sprintf('%d', x), temp3, ...
    'UniformOutput',false);
%temp4 = [];
%figure, plot(data.profile.ang*pi/180, temp, '-k')
figure
pp(data.profile.ang*pi/180, temp, ...
    'RingStep',temp5, ...
    'RingTickLabel',temp4, ...
    'ThetaDirection','cw', ...
    'ThetaStartAngle',+270, ...
    'MaxValue',temp1, ...
    'CentreValue',temp2, ...
    'Marker','.', ...
    'LineStyle','-', ...
    'LineColor','k', ...
    'LineWidth',2 ...
)
axis equal
title(tit, 'Interpreter','none')
if ~isempty(dir)
  saveas(gcf, fullfile(dir, filename))
  close(gcf)
end
end
%return

temp1 = max(max(data.sphharm.final), ...
            max(data.sphharm.final_fit));
temp2 = min(min(data.sphharm.final), ...
            min(data.sphharm.final_fit));
figure
pp(data.sphharm.ang*pi/180, data.sphharm.final, ...
    'ThetaDirection','cw', ...
    'ThetaStartAngle',+270, ...
    'MaxValue',temp1, ...
    'CentreValue',temp2, ...
    'Marker','.', ...
    'LineStyle','-', ...
    'LineColor','k', ...
    'LineWidth',2 ...
)
hold on
pp(data.sphharm.ang*pi/180, data.sphharm.final_fit, ...
    'ThetaDirection','cw', ...
    'ThetaStartAngle',+270, ...
    'MaxValue',temp1, ...
    'CentreValue',temp2, ...
    'Marker','.', ...
    'LineStyle','-', ...
    'LineWidth',2 ...
)
axis equal
legend('original','fitted')
tit = sprintf('%s (%s)\n%s', ...
    (data.profile.final_label), data.profile.final_units, data.filename);
title(tit, 'Interpreter','none')
if ~isempty(dir)  
  filename = [data.filename '-' data.profile.final_units '-fit.png'];
  saveas(gcf, fullfile(dir, filename))
  close(gcf)
end

temp1 = max(max(data.sphharm.original), ...
            max(data.sphharm.original_fit));
temp2 = min(min(data.sphharm.original), ...
            min(data.sphharm.original_fit));
figure
pp(data.sphharm.ang*pi/180, data.sphharm.original, ...
    'ThetaDirection','cw', ...
    'ThetaStartAngle',+270, ...
    'MaxValue',temp1, ...
    'CentreValue',temp2, ...
    'Marker','.', ...
    'LineStyle','-', ...
    'LineColor','k', ...
    'LineWidth',2 ...
)
hold on
pp(data.sphharm.ang*pi/180, data.sphharm.original_fit, ...
    'ThetaDirection','cw', ...
    'ThetaStartAngle',+270, ...
    'MaxValue',temp1, ...
    'CentreValue',temp2, ...
    'Marker','.', ...
    'LineStyle','-', ...
    'LineWidth',2 ...
)
axis equal
legend('original','fitted')
tit = sprintf('%s (%s)\n%s', ...
    (data.profile.original_label), data.profile.original_units, data.filename);
title(tit, 'Interpreter','none')
if ~isempty(dir)  
  filename = [data.filename '-' data.profile.original_units '-fit.png'];
  saveas(gcf, fullfile(dir, filename))
  close(gcf)
end

figure
  imagesc(data.densemap.azim_domain, data.densemap.elev_domain, data.densemap.final_grid)
  xlabel('Azimuth (degrees)')
  ylabel('Elevation angle (degrees)')
  set(gca, 'YDir','normal')
  set(gca, 'XTick',0:90:360)
  set(gca, 'YTick',-90:30:+90)
  tit = sprintf('%s (%s)', ...
    (data.profile.final_label), data.profile.final_units);
  h = colorbar;  title(h, tit, 'Interpreter','none')
  title(data.filename, 'Interpreter','none')
if ~isempty(dir)  
  filename = [data.filename '-' data.profile.final_units '-map.png'];
  saveas(gcf, fullfile(dir, filename))
  close(gcf)
end

antenna_gain_plot6 (data)
if ~isempty(dir)  
  filename = [data.filename '-' data.profile.final_units '-surf.png'];
  saveas(gcf, fullfile(dir, filename))
  view(-37.5+180, 0)
  filename = [data.filename '-' data.profile.final_units '-surf2.png'];
  saveas(gcf, fullfile(dir, filename))
  close(gcf)
end

%return

temp = data.sphharm.final_fit - data.sphharm.final;
%temp = abs(temp);
figure('Visible','off')
pp(data.sphharm.ang*pi/180, temp, ...
    'ThetaDirection','cw', ...
    'ThetaStartAngle',+270, ...
    'MaxValue',max(temp), ...
    'CentreValue',min(temp), ...
    'Marker','.', ...
    'LineWidth',2 ...
)
axis equal
tit = sprintf('Fitted %s residual (%s)\n%s', ...
  lower(data.profile.final_label), data.profile.final_units, data.filename);
title(tit, 'Interpreter','none')
%saveas(gcf, fullfile(dir, ['linear-' data.filename '.png']))
%close(gcf)

%return

temp = data.sphharm.final_fit - data.sphharm.final;
%temp = abs(temp);
temp = 100 * temp ./ data.sphharm.final;
figure('Visible','off')
pp(data.sphharm.ang*pi/180, temp, ...
    'ThetaDirection','cw', ...
    'ThetaStartAngle',+270, ...
    'MaxValue',max(temp), ...
    'CentreValue',min(temp), ...
    'Marker','.', ...
    'LineWidth',2 ...
)
axis equal
tit = sprintf('Fitted %s residual (%%)\n%s', ...
  lower(data.profile.final_label), data.filename);
title(tit, 'Interpreter','none')
%saveas(gcf, fullfile(dir, ['linear-' data.filename '.png']))
%close(gcf)

end
