{
  imports = [ ./hosts.nix ];

  #DO NOT MANUALLY RESOLVE TO IP'S as if your system is dependent on using any of the domains, and if it has been moved to diffrent server, as rebuilding with the broken ip will be an issue.
  networking.extraHosts = ''
    quora.com www.quora.com
    142.250.182.196 google.in
    142.250.182.196 google.com
    49.44.79.236 githubusercontent.com
    142.250.182.196 google.co.in
    172.217.167.174 youtube.com
    163.53.78.110 flipkart.com
    52.95.116.115 amazon.in
  '';
}

