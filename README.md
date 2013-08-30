# shell-otp

Generate six-digit two-factor auth keys from your shell, compatible with Google Authenticator and similar.

## Are you damaged or something?

Well, why not? I don't see why your laptop can't be the 'something you have' portion of 'something you have' and 'something you know'.

## Alright, how do I set it up?

Other than this repo, there are two things you need to get started. One's easy, and one's somewhere between 'annoying' and 'not currently possible' depending on your technical skill and current setup.

### The easy bit

You'll need [OATH Toolkit](http://www.nongnu.org/oath-toolkit/), specifically the `oathtool` binary, in your `$PATH`. You'll be able to get it through your OS' package manager, with something like

`brew install oath-toolkit` (Mac OS X, with [Homebrew](http://brew.sh))

`apt-get install oathtool` (Linux, dpkg-based)

`yum install oathtool` (Linux, rpm-based)

or by compiling it yourself.

### The hard bit

You'll need the keys for your two-factor authentication accounts. You can achieve this a few ways:

* Root your Android device, and extract the keys from the Google Authenticator sqlite database (this is what I did, and it works).
* Jailbreak your iOS device, and go hunting for the Google Authenticator database (may or may not work).
* If you have your keys in an iOS device and can't jailbreak, you're pretty much SOL, and you'll have to...
* Disable and re-enable two-factor auth for all of your accounts, saving the QR codes and using a QR code reader to extract the keys.

## When you have everything

You'll need to pick or create a directory, preferably with no spaces in the path but it's not a huge deal. See the **Security Concerns** section below for guidance on where to put this directory.

For each of your keys, create a file with an easy to remember short name, containing the key as text without a trailing newline.

For an example, see the file `example-key` in this repo.

## Configuration and installation

Open up `shell-otp.txt` in this repo, because it's configurin' time.

Set `OATH_KEY_HOME` in the first line to point at the directory containing your keys.

If you're on Mac OS X, the function will detect it, and copy the generated key to the clipboard as well as printing it to the console.  If you'd rather not have that behaviour, comment out the line

`echo -n $CODE | pbcopy`

Then, if you use bash, uncomment the final line. Leave it commented if you're a zsh user.

Finally, copy and paste the whole thing at the end of your shell's rc or profile file. We're talking about something like `.zshrc` or `.bashrc` or `.bash_profile` or `.profile` (or something else if you use a weird shell). The easy way to do this (assuming zsh) is

`cat /path/to/shell-otp.txt >> .zshrc`

In the name of all that is good and holy, make sure you've got **TWO** 'greater-than' symbols in that command line, or you'll kill everything else in the file and cry forever.

## Usage

Dead easy. If you want to generate a password for 'service-name', just run:

`p service-name`

It'll return a six-digit number, which is your temporally-keyed password. If you're using Mac OS X and you've left clipboard functionality enabled, it'll also be silently copied to your clipboard (without a newline at the end) for pasting.

## Security concerns

You've got plaintext keys sitting on your hard disk, so be smart. A nice way to keep things reasonably secure is to store your keys on an EncFS container or encrypted disk image, which you can mount only when you need to generate a password.  Remember, full-disk crypto won't help you if something goes looking for the key files while your machine is running.

If you're feeling cavalier, at the very least make sure your modes are fairly draconian. I'd suggest 600 for the files, and 700 for the directory.

## Coming soon (when I get bored)

* an install script (it's probably going to be ruby)
* a script to pull keys out of an Android Google Authenticator sqlite db (also ruby)
* openssl crypto for the key files at rest
* encfs wrap/unwrap integration
* ascii dongs at unexpected times

## Help, it's fucked!

That's what [Issues](https://github.com/daveio/shell-otp/issues) is for. Drop me a ticket and I'll see what I can do.