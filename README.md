# pass-otp

Generate six-digit two-factor auth keys from your shell and
[Pass](https://www.passwordstore.org/) storage,
compatible with Google Authenticator and similar.

## Installation

    git clone https://github.com/jcu-eresearch/pass-otp
    cd pass-otp
    echo "$pwd/pass-otp.sh" >> .bashrc

At the moment, the script is written to work with `bash`. Pull requests are
welcome with support for other shells or platforms.

### Dependencies

In short, you need `oathtool` and `pass` binaries in your `$PATH`.  You'll be
able to get them through your package manager, with something like:

`yum install oathtool pass` (Linux, rpm-based)

`apt-get install oathtool pass` (Linux, dpkg-based)

`brew install oath-toolkit pass` (Mac OS X, with [Homebrew](http://brew.sh))

or by compiling them yourself.

You'll also need to have `pass` configured, which requires GPG to be
configured, your `.password-store` directory to be available and so on.

### Keys

You'll need the keys for your two-factor authentication accounts. You can
achieve this a few ways:

* Disable and re-enable two-factor auth for all of your accounts, saving the
  QR codes and using a QR code reader to extract the keys. Much of the time
  the service will give you the raw text-based key; just copy this.
* Root your Android device, and extract the keys from the Google Authenticator
  sqlite database.
* Jailbreak your iOS device, and go hunting for the Google Authenticator
  database (may or may not work).

Put each of your keys into `pass` in the same way that you normally would,
using the following, and note the location:

    pass insert keys/github

## Usage

If you want to generate a password, just run the following:

    otp path/to/key

where `path/to/key` is what you'd normally use to reference your `pass` file.
So in the case of the `pass insert` above, you'd use:

    otp keys/github

This returns a six-digit number, which is your temporally-keyed password.
This uses `pass` and `gpg` under the hood, so if your GPG key isn't already
unlocked in your agent, you'll be prompted for its passphrase.

`otp` also utilises tab-completion care of `pass` so you can tab complete the
path to the key at any time.

## Contributing

Report any concerns at [GitHub
Issues](https://github.com/jcu-eresearch/pass-otp/issues). Pull requests and
changes to improve the code are welcome; feel free to open an issue to discuss
before putting too much time and effort into a change.
