close all;
Dstart=1872;
Dend=2017;
f1n=figure(1);
    subplot(2,3,1)
    plot([Dstart:Dend],100*oo_.SmoothedVariables.ESrdy1(Dstart-1869:Dend-1869)) %#ok<*NBRAK>
    title('US')
    subplot(2,3,2)
    plot([Dstart:Dend],100*oo_.SmoothedVariables.ESrdy2(Dstart-1869:Dend-1869))
    title('Germany')
    subplot(2,3,3)
    plot([Dstart:Dend],100*oo_.SmoothedVariables.ESrdy3(Dstart-1869:Dend-1869))
    title('UK')
    subplot(2,3,4)
    plot([Dstart:Dend],100*oo_.SmoothedVariables.ESrdy4(Dstart-1869:Dend-1869))
    title('France')
    subplot(2,3,5)
    plot([Dstart:Dend],100*oo_.SmoothedVariables.ESrdy5(Dstart-1869:Dend-1869))
    xlabel('Smoothed total R&D over GDP')
    title('REU')
    subplot(2,3,6)
    plot([Dstart:Dend],100*oo_.SmoothedVariables.ESrdy6(Dstart-1869:Dend-1869))
    title('RMA')
    f1n.Children(1).Position=[0.05*3+0.8/3*2, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f1n.Children(2).Position=[0.05*2+0.8/3*1, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f1n.Children(3).Position=[0.05*1+0.8/3*0, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f1n.Children(4).Position=[0.05*3+0.8/3*2, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f1n.Children(5).Position=[0.05*2+0.8/3*1, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f1n.Children(6).Position=[0.05*1+0.8/3*0, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f1n.Position=[200 200 1920 1080];
    
    YMin = Inf;
    YMax = -Inf;
    for i = 1 : 6
        YBounds = get( f1n.Children( i ), 'YLim' );
        YMin = min( YMin, YBounds( 1 ) );
        YMax = max( YMax, YBounds( 2 ) );
    end
    for i = 1 : 6
        set( f1n.Children( i ), 'YLim', [ max( 0, YMin ), YMax ] );
    end
    
    savefig('Smoothed total R&D to GDP')
    saveas(gcf,'Smoothed total R&D to GDP','emf')
f2n=figure(2);
    subplot(2,3,1)
    plot([Dstart:Dend],oo_.SmoothedVariables.PRDY1(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.PRDY1(Dstart-1869:Dend-1869)))
    title('US')
    subplot(2,3,2)
    plot([Dstart:Dend],oo_.SmoothedVariables.PRDY2(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.PRDY2(Dstart-1869:Dend-1869)))
    title('Germany')
    subplot(2,3,3)
    plot([Dstart:Dend],oo_.SmoothedVariables.PRDY3(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.PRDY3(Dstart-1869:Dend-1869)))
    title('UK')
    subplot(2,3,4)
    plot([Dstart:Dend],oo_.SmoothedVariables.PRDY4(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.PRDY4(Dstart-1869:Dend-1869)))
    title('France')
    subplot(2,3,5)
    plot([Dstart:Dend],oo_.SmoothedVariables.PRDY5(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.PRDY5(Dstart-1869:Dend-1869)))
    title('REU')
    subplot(2,3,6)
    plot([Dstart:Dend],oo_.SmoothedVariables.PRDY6(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.PRDY6(Dstart-1869:Dend-1869)))
    title('RMA')
    subplot(2,3,1)
    hold on
    plot([Dstart:Dend],oo_.SmoothedVariables.GRDY1(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.GRDY1(Dstart-1869:Dend-1869)))
    title('US')
    subplot(2,3,2)
    hold on
    plot([Dstart:Dend],oo_.SmoothedVariables.GRDY2(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.GRDY2(Dstart-1869:Dend-1869)))
    title('Germany')
    subplot(2,3,3)
    hold on
    plot([Dstart:Dend],oo_.SmoothedVariables.GRDY3(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.GRDY3(Dstart-1869:Dend-1869)))
    title('UK')
    subplot(2,3,4)
    hold on
    plot([Dstart:Dend],oo_.SmoothedVariables.GRDY4(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.GRDY4(Dstart-1869:Dend-1869)))
    title('France')
    subplot(2,3,5)
    hold on
    plot([Dstart:Dend],oo_.SmoothedVariables.GRDY5(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.GRDY5(Dstart-1869:Dend-1869)))
    xlabel('Smoothed private (blue) & government (orange) R&D over GDP, percentage point deviations from window mean')
    title('REU')
    subplot(2,3,6)
    hold on
    plot([Dstart:Dend],oo_.SmoothedVariables.GRDY6(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.GRDY6(Dstart-1869:Dend-1869)))
    title('RMA')
    f2n.Children(1).Position=[0.05*3+0.8/3*2, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f2n.Children(2).Position=[0.05*2+0.8/3*1, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f2n.Children(3).Position=[0.05*1+0.8/3*0, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f2n.Children(4).Position=[0.05*3+0.8/3*2, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f2n.Children(5).Position=[0.05*2+0.8/3*1, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f2n.Children(6).Position=[0.05*1+0.8/3*0, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f2n.Position=[200 200 1920 1080];
    
    YMin = Inf;
    YMax = -Inf;
    for i = 1 : 6
        YBounds = get( f2n.Children( i ), 'YLim' );
        YMin = min( YMin, YBounds( 1 ) );
        YMax = max( YMax, YBounds( 2 ) );
    end
    for i = 1 : 6
        set( f2n.Children( i ), 'YLim', [ YMin, YMax ] );
    end
    
    savefig('Smoothed components of R&D to GDP')
    saveas(gcf,'Smoothed components of R&D to GDP','emf')
f3n=figure(3);
    subplot(2,3,1)
    plot([Dstart:Dend],100*oo_.SmoothedVariables.OECDihy1(Dstart-1869:Dend-1869))
    title('US')
    subplot(2,3,2)
    plot([Dstart:Dend],100*oo_.SmoothedVariables.OECDihy2(Dstart-1869:Dend-1869))
    title('Germany')
    subplot(2,3,3)
    plot([Dstart:Dend],100*oo_.SmoothedVariables.OECDihy3(Dstart-1869:Dend-1869))
    title('UK')
    subplot(2,3,4)
    plot([Dstart:Dend],100*oo_.SmoothedVariables.OECDihy4(Dstart-1869:Dend-1869))
    title('France')
    subplot(2,3,5)
    plot([Dstart:Dend],100*oo_.SmoothedVariables.OECDihy5(Dstart-1869:Dend-1869))
    xlabel('Smoothed human capital investment over GDP')
    title('REU')
    subplot(2,3,6)
    plot([Dstart:Dend],100*oo_.SmoothedVariables.OECDihy6(Dstart-1869:Dend-1869))
    title('RMA')
    f3n.Children(1).Position=[0.05*3+0.8/3*2, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f3n.Children(2).Position=[0.05*2+0.8/3*1, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f3n.Children(3).Position=[0.05*1+0.8/3*0, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f3n.Children(4).Position=[0.05*3+0.8/3*2, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f3n.Children(5).Position=[0.05*2+0.8/3*1, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f3n.Children(6).Position=[0.05*1+0.8/3*0, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f3n.Position=[200 200 1920 1080];
    
    YMin = Inf;
    YMax = -Inf;
    for i = 1 : 6
        YBounds = get( f3n.Children( i ), 'YLim' );
        YMin = min( YMin, YBounds( 1 ) );
        YMax = max( YMax, YBounds( 2 ) );
    end
    for i = 1 : 6
        set( f3n.Children( i ), 'YLim', [ max( 0, YMin ), YMax ] );
    end
    
    savefig('Smoothed human capital investment to GDP')
    saveas(gcf,'Smoothed human capital investment to GDP','emf')
f4n=figure(4);
    subplot(2,3,1)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPT1(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPT1(Dstart-1869:Dend-1869))))
    title('US')
    subplot(2,3,2)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPT2(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPT2(Dstart-1869:Dend-1869))))
    title('Germany')
    subplot(2,3,3)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPT3(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPT3(Dstart-1869:Dend-1869))))
    title('UK')
    subplot(2,3,4)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPT4(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPT4(Dstart-1869:Dend-1869))))
    title('France')
    subplot(2,3,5)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPT5(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPT5(Dstart-1869:Dend-1869))))
    title('REU')
    subplot(2,3,6)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPT6(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPT6(Dstart-1869:Dend-1869))))
    title('RMA')
    subplot(2,3,1)
    hold on;
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPNT1(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPNT1(Dstart-1869:Dend-1869))))
    title('US')
    subplot(2,3,2)
    hold on;
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPNT2(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPNT2(Dstart-1869:Dend-1869))))
    title('Germany')
    subplot(2,3,3)
    hold on;
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPNT3(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPNT3(Dstart-1869:Dend-1869))))
    title('UK')
    subplot(2,3,4)
    hold on;
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPNT4(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPNT4(Dstart-1869:Dend-1869))))
    title('France')
    subplot(2,3,5)
    hold on;
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPNT5(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPNT5(Dstart-1869:Dend-1869))))
    title('REU')
    subplot(2,3,6)
    hold on;
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPNT6(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPNT6(Dstart-1869:Dend-1869))))
    title('RMA')
    subplot(2,3,1)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPW1(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPW1(Dstart-1869:Dend-1869))))
    title('US')
    subplot(2,3,2)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPW2(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPW2(Dstart-1869:Dend-1869))))
    title('Germany')
    subplot(2,3,3)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPW3(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPW3(Dstart-1869:Dend-1869))))
    title('UK')
    subplot(2,3,4)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPW4(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPW4(Dstart-1869:Dend-1869))))
    title('France')
    subplot(2,3,5)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPW5(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPW5(Dstart-1869:Dend-1869))))
    xlabel('Smoothed private human capital in the tradeable (blue) / non-tradeable (orange) / widget (yellow) sector, log point deviations from window mean')
    title('REU')
    subplot(2,3,6)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HPW6(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HPW6(Dstart-1869:Dend-1869))))
    title('RMA')
    f4n.Children(1).Position=[0.05*3+0.8/3*2, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f4n.Children(2).Position=[0.05*2+0.8/3*1, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f4n.Children(3).Position=[0.05*1+0.8/3*0, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f4n.Children(4).Position=[0.05*3+0.8/3*2, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f4n.Children(5).Position=[0.05*2+0.8/3*1, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f4n.Children(6).Position=[0.05*1+0.8/3*0, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f4n.Position=[200 200 1920 1080];
    
    YMin = Inf;
    YMax = -Inf;
    for i = 1 : 6
        YBounds = get( f4n.Children( i ), 'YLim' );
        YMin = min( YMin, YBounds( 1 ) );
        YMax = max( YMax, YBounds( 2 ) );
    end
    for i = 1 : 6
        set( f4n.Children( i ), 'YLim', [ YMin, YMax ] );
    end
    
    savefig('Smoothed components of human capital')
    saveas(gcf,'Smoothed components of human capital','emf')
f5n=figure(5);
    subplot(2,3,1)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HG1(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HG1(Dstart-1869:Dend-1869))))
    title('US')
    subplot(2,3,2)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HG2(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HG2(Dstart-1869:Dend-1869))))
    title('Germany')
    subplot(2,3,3)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HG3(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HG3(Dstart-1869:Dend-1869))))
    title('UK')
    subplot(2,3,4)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HG4(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HG4(Dstart-1869:Dend-1869))))
    title('France')
    subplot(2,3,5)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HG5(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HG5(Dstart-1869:Dend-1869))))
    xlabel('Smoothed government R&D capital, log point deviations from window mean')
    title('REU')
    subplot(2,3,6)
    plot([Dstart:Dend],100*(oo_.SmoothedVariables.log_HG6(Dstart-1869:Dend-1869)-mean(oo_.SmoothedVariables.log_HG6(Dstart-1869:Dend-1869))))
    title('RMA')
    f5n.Children(1).Position=[0.05*3+0.8/3*2, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f5n.Children(2).Position=[0.05*2+0.8/3*1, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f5n.Children(3).Position=[0.05*1+0.8/3*0, 0.05*1+0.85/2*0, 0.8/3, 0.85/2];
    f5n.Children(4).Position=[0.05*3+0.8/3*2, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f5n.Children(5).Position=[0.05*2+0.8/3*1, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f5n.Children(6).Position=[0.05*1+0.8/3*0, 0.05*2+0.85/2*1, 0.8/3, 0.85/2];
    f5n.Position=[200 200 1920 1080];
    
    YMin = Inf;
    YMax = -Inf;
    for i = 1 : 6
        YBounds = get( f5n.Children( i ), 'YLim' );
        YMin = min( YMin, YBounds( 1 ) );
        YMax = max( YMax, YBounds( 2 ) );
    end
    for i = 1 : 6
        set( f5n.Children( i ), 'YLim', [ YMin, YMax ] );
    end
    
    savefig('Smoothed government R&D capital')
    saveas(gcf,'Smoothed government R&D capital','emf')
    