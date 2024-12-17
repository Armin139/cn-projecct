

package inet.examples.ansa.hsrp.testActiveUp;

import ansa.node.ANSA_HSRPRouter;
import ansa.node.ANSA_Host;
import inet.common.lifecycle.LifecycleController;
import inet.common.scenario.ScenarioManager;
import inet.node.ethernet.EtherSwitch;
import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.ethernet.Eth100M;

network testActiveUp
{
    @display("bgb=338,280");

    submodules:
        R1: ANSA_HSRPRouter {
            @display("p=111,46");
        }
        R2: ANSA_HSRPRouter {
            @display("p=205,46");
        }
        R3: ANSA_HSRPRouter {
            @display("p=288,46");
        }
        PC1: ANSA_Host {
            @display("p=136,201");
        }
        PC2: ANSA_Host {
            @display("p=273,200");
        }
        SW1: EtherSwitch {
            @display("p=205,139");
        }
        configurator: IPv4NetworkConfigurator {
            parameters:
                config = xml("<config>"+
                            "<interface hosts='R1' towards='SW1 PC1' address='192.168.1.1' netmask='255.255.255.0' />"+
                            "<interface hosts='R2' towards='SW1 PC1' address='192.168.1.2' netmask='255.255.255.0' />"+
                            "<interface hosts='R3' towards='SW1 PC1' address='192.168.1.3' netmask='255.255.255.0' />"+

       						"<interface hosts='PC1' address='192.168.1.10' netmask='255.255.255.0' />"+
       						"<interface hosts='PC2' address='192.168.1.11' netmask='255.255.255.0' />"+
                            "</config>");
                addStaticRoutes = true;
                addDefaultRoutes = true;
                @display("p=48,31");
        }

        scenarioManager: ScenarioManager {
            @display("p=48,73");
        }

        lifecycleController: LifecycleController {
            @display("p=48,115");
        }
    connections:
        R1.ethg++ <--> Eth100M <--> SW1.ethg++;
        R2.ethg++ <--> Eth100M <--> SW1.ethg++;
        R3.ethg++ <--> Eth100M <--> SW1.ethg++;
        SW1.ethg++ <--> Eth100M <--> PC1.ethg++;
        SW1.ethg++ <--> Eth100M <--> PC2.ethg++;
}
