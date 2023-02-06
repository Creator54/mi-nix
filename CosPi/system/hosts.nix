{
  networking.hostFiles = [
    (builtins.fetchurl {
      url = "https://adaway.org/hosts.txt";
      sha256 = "sha256:10jrncass5nc07lr3dlziscmfk6wm43wiyvp4zmrs7zlnimj97cs";
    })
    (builtins.fetchurl {
      url = "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt";
      sha256 = "sha256:1bcicm9g14b60qyiy3awxxwh3f280vvfl8aprpi1g1irjgiy6ag2";
    })
    (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
      sha256 = "sha256:0y4sghzlnv0gyqdqf20c0la1y11fbs0ydynvq76kk68f0ppv47c1";
    })
    (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/creator54/youtube_ad_blocklist/master/blocklist.txt";
      sha256 = "sha256:03k4pln8bvj5h8wx95rqcva6b1khla1j2fdd59bnclax6cpfynsa";
    })
  ];
}

