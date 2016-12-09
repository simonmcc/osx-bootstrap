Based on [http://il.luminat.us/blog/2014/04/19/how-i-fully-automated-os-x-with-ansible/]()

Install CA Cert: [https://derflounder.wordpress.com/2011/03/13/adding-new-trusted-root-certificates-to-system-keychain/]()

Other sources

* [https://github.com/hjuutilainen/dotfiles]()
* [https://github.com/geerlingguy/dotfiles/blob/master/.osx]()
* [https://gist.github.com/saetia/1623487]()
* [https://gist.github.com/1623487/88bb6766048133d2a68403d02531ce62c46ad404]()
* [https://jamfnation.jamfsoftware.com/discussion.html?id=12075]()
* [https://github.com/mathiasbynens/dotfiles/blob/master/.osx]()
* [https://raw.githubusercontent.com/mathiasbynens/dotfiles/master/.osx]()
* [https://github.com/ZogStriP/dotfiles/blob/master/setup/set-defaults.sh]()
* [http://wiki.eri.ucsb.edu/sysadm/OS_X_CLI]()
* [https://github.com/spencergibb/battleschool]()
* [http://www.nickhammond.com/automating-development-environment-ansible/]()


App Store Apps:

* [https://itunes.apple.com/gb/app/wunderlist-to-do-list-tasks/id410628904?mt=12]()
* [https://itunes.apple.com/gb/app/airmail-2.0/id918858936?mt=12]()
* [https://itunes.apple.com/gb/app/istats/id628673206?mt=12]()
* [https://itunes.apple.com/gb/app/tweetbot-for-twitter/id557168941?mt=12]()
* [https://itunes.apple.com/gb/app/remoter/id486899236?mt=12]()
* [https://itunes.apple.com/gb/app/telephone/id406825478?mt=12]()
* [https://itunes.apple.com/gb/app/lastpass-password-manager/id926036361?mt=12]()
* [https://itunes.apple.com/gb/app/battery-monitor/id413678017?mt=12]()
* [https://itunes.apple.com/gb/app/parallels-2x-rdp-remote-desktop/id600925318?mt=12]()


## DMG apps

* https://www.myroom.hpe.com/downloadfiles/10.4.0.0174-installmyroomMacIntel.dmg

## App Store Apps via MAS
At last! a CLI client to MAS: [https://github.com/argon/mas]()

```
brew install argon/mas/mas
```

Current apps:

```
$ mas list
628673206 iStats
405399194 Kindle
409183694 Keynote
580788158 VSD Viewer
468946727 PeakHour
486899236 Remoter
823766827 OneDrive
406825478 Telephone
410628904 Wunderlist
557168941 Tweetbot
413678017 BatteryMonitor
505795901 UK Salary Calculator
488764545 The Clock
926036361 LastPass
600925318 Parallels Client
```

Install in a blast (hopefully ansible support coming soon, puppet provider already out):

```
$ for p in 628673206 405399194 409183694 580788158 468946727 486899236 823766827 406825478 410628904 557168941 413678017 505795901 488764545 926036361 600925318 ; do mas install $p ; done
```


Trouble shooting
================

[https://github.com/caskroom/homebrew-cask/issues/15930]()

    brew update; brew cleanup; brew cask cleanup
    brew uninstall --force brew-cask; brew update
