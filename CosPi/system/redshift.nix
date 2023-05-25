{ ... }:

{
  services.redshift = {
    enable = true;
    brightness = {
      day = "1";
      night = "0.4";
    };

    temperature = {
      day = 5500;
      night = 5300;
    };
  };

  #location.provider = "geoclue2";#need to provide location info
  location = {
    latitude = 12.9719;
    longitude = 77.5937;
  };
}
